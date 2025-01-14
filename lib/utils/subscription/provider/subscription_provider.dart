import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:quiz_me/main/imports.dart';
import 'package:quiz_me/utils/subscription/provider/subscription_service.dart';

class SubscriptionProvider with ChangeNotifier, WidgetsBindingObserver {
  List<Package> productList = [];
  int selectedItemIndex = 1;
  bool isPremium = false;
  bool hasUsedTrial = false;
  bool isLoading = false;
  bool isTrialEligible = false;
  bool isSubscriptionProcessing = false;
  bool isCanceledButActive = false;
  final SubscriptionService _subscriptionService = SubscriptionService();

  bool _lastPremiumState = false;
  Map<String, IntroEligibility> introEligibility = {};

  SubscriptionProvider() {
    fetchProducts();
    checkPremiumStatus();
    _addPurchasesListener();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkPremiumStatus();
    }
  }

  void _addPurchasesListener() {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      checkPremiumStatus();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void selectItem(int index) {
    selectedItemIndex = index;
    notifyListeners();
  }

  /// Fetch products from RevenueCat API and check trial eligibility
  Future<void> fetchProducts() async {
    try {
      setLoading(true); // Show loading while fetching
      List<Package> products =
          await _subscriptionService.fetchAvailableProducts();
      productList = products;

      // Check trial eligibility for iOS users only
      if (Platform.isIOS) {
        final Map<String, IntroEligibility> eligibility =
            await Purchases.checkTrialOrIntroductoryPriceEligibility(
          products.map((p) => p.storeProduct.identifier).toList(),
        );
        introEligibility = eligibility;
        notifyListeners();
      }

      setLoading(false); // Remove loading once fetched
      notifyListeners();
    } catch (e) {
      setLoading(false);
      showWarningToast('Alert!!!', 'Failed to fetch products: ${e.toString()}');
    }
  }

  /// Check the user's premium status
  Future<void> checkPremiumStatus() async {
    try {
      setLoading(true); // Show loading while checking the premium status
      final purchaserInfo = await Purchases.getCustomerInfo();
      final entitlements = purchaserInfo.entitlements.active;
      if (entitlements.containsKey('Premium Plans')) {
        final premiumPlan = entitlements['Premium Plans']!;
        final expirationDateStr = premiumPlan.expirationDate;

        if (premiumPlan.isActive) {
          _updatePremiumState(true);
          if (expirationDateStr != null) {
            final expirationDate = DateTime.parse(expirationDateStr);
            if (expirationDate.isBefore(DateTime.now())) {
              _updatePremiumState(false);
              showWarningToast('Alert!!!', 'Your subscription has expired.');
            } else if (!premiumPlan.willRenew) {
              isCanceledButActive = true;
              showWarningToast('Alert!!!',
                  'Subscription canceled but active until ${expirationDate.toLocal()}.');
            }
          }
        } else {
          if (!isSubscriptionProcessing) {
            // Only show if not processing a subscription
            _updatePremiumState(false);
            showWarningToast('Alert!!!', 'Your subscription is inactive.');
          }
        }
      } else {
        if (!isSubscriptionProcessing) {
          // Only show if not processing a subscription
          _updatePremiumState(false);
        }
      }

      // Check if the user has used the trial
      hasUsedTrial = purchaserInfo.nonSubscriptionTransactions.isNotEmpty;
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      _updatePremiumState(false);
      showWarningToast('Alert!!!', 'Error checking subscription status');
    }
  }

  /// Handle premium state changes and avoid redundant toasts
  void _updatePremiumState(bool isNowPremium) {
    if (isPremium != isNowPremium) {
      isPremium = isNowPremium;
      notifyListeners();
    }
    if (_lastPremiumState != isNowPremium) {
      _lastPremiumState = isNowPremium;
    }
  }

  /// Set loading state
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// Purchase the selected product
  Future<void> purchaseProduct(Package package, BuildContext context) async {
    setLoading(true);
    isSubscriptionProcessing = true; // Start subscription processing
    notifyListeners();

    try {
      bool isPurchased = await _subscriptionService.purchasePackage(package);
      isSubscriptionProcessing = false; // End subscription processing
      setLoading(false);

      if (isPurchased) {
        _updatePremiumState(true);
        Push.back();
        showSuccessToast('Purchase successful!', 'You are now a premium user.');
      }
    } catch (e) {
      isSubscriptionProcessing = false;
      setLoading(false);
      showWarningToast('Alert!!!', 'Failed to complete purchase');
    }
  }

  Future<void> handleSubscriptionNavigation(BuildContext context) async {
    if (!isPremium) {
      showWarningToast('Alert!!!', 'Waiting for subscription to complete...');
    }
  }

  Widget buildPurchaseButton(BuildContext context) {
    String buttonText;

    // Check the conditions and update the button text accordingly
    if (isPremium) {
      buttonText =
          isCanceledButActive ? 'Subscription Active (Canceled)' : 'Premium';
    } else if (!isPremium && isTrialEligible) {
      buttonText =
          'Start Free Trial'; // If eligible for the trial, offer the trial
    } else if (hasUsedTrial) {
      buttonText = 'Get Pro'; // If the user has already used the trial
    } else {
      buttonText =
          'Upgrade to Pro'; // Default case for non-premium users without a trial
    }

    return Padding(
      padding: gapSymmetric(horizontal: 20),
      child: CustomButton(
        gradient: AppColors.gradient,
        onPressed: () {
          if (productList.isNotEmpty && selectedItemIndex != -1) {
            purchaseProduct(productList[selectedItemIndex], context);
          } else {
            showWarningToast(
                'Alert!!!', 'No product selected. Please try again.');
          }
        },
        widget: Text(buttonText),
      ),
    );
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    try {
      await _subscriptionService.restorePurchases();
      await checkPremiumStatus();
      showSuccessToast('Success', 'Purchase restored successfully.');
    } catch (e) {
      showWarningToast(
          'Alert!!!', 'Failed to restore purchases: ${e.toString()}');
    }
  }

  /// Build the restore purchase button
  Widget buildRestorePurchaseButton() {
    return ElevatedButton(
      onPressed: restorePurchases,
      child: Text(
        'Restore Purchase',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Push.context).textTheme.bodySmall,
      ),
    );
  }
}
