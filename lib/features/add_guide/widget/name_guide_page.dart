import 'package:quiz_me/main/imports.dart';

class NameGuidePage extends StatelessWidget {
  const NameGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none);
    return Consumer<AddGuideProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              margin: gapAll(8.0),
              padding: gapSymmetric(vertical: 20, horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: Theme.of(context).hintColor.withOpacity(0.25),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: h(30),
                    backgroundColor: Theme.of(context).cardColor,
                    child: SvgPicture.asset(
                      'assets/icons/name_guide.svg',
                      height: h(30),
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Text(
                    'Study Guide Name',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Enter your study guide name i.e chemistry',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: h(10)),
                  TextFormField(
                    controller: provider.guideNameController,
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      hintText: 'Write here ..',
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      fillColor: Theme.of(context).cardColor,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: gapSymmetric(vertical: 10, horizontal: 8),
              child: CustomButton(
                width: double.infinity,
                borderRadius: 8,
                backgroundColor: Theme.of(context).primaryColor,
                widget: Text(
                  'Next',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
                height: h(50),
                onPressed: () {
                  if (provider.guideNameController.text.isEmpty) {
                    showWarningToast('Alert!!!', 'Guide name must required*');
                  } else {
                    provider.next(1);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
