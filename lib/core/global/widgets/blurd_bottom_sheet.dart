import 'dart:ui';
import 'package:quiz_me/main/imports.dart';

Future<T?> showBlurredBarBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  double elevation = 0,
  ShapeBorder shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  ),
  Clip? clipBehavior,
  Curve? animationCurve,
  Duration? duration,
  RouteSettings? settings,
  double? closeProgressThreshold,
  AnimationController? secondAnimation,
  Color? backgroundColor,
  Color? barrierColor,
  bool bounce = false,
  bool useRootNavigator = true,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  final sheetContent = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: h(16)),
      Container(
        height: h(3),
        width: h(30),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor.withOpacity(0.25),
          borderRadius: const BorderRadius.all(Radius.circular(3)),
        ),
      ),
      SizedBox(height: h(16)),
      Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: SizedBox(width: double.infinity, child: builder(context)),
      ),
    ],
  );

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Material(
        shape: shape,
        clipBehavior: clipBehavior ??
            (Theme.of(context).brightness == Brightness.dark
                ? Clip.antiAlias
                : Clip.none),
        color: backgroundColor,
        elevation: elevation,
        child: Theme.of(context).brightness == Brightness.dark
            ? sheetContent
            : Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                child: sheetContent,
              ),
      ),
    ),
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    backgroundColor: Colors.transparent,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}
