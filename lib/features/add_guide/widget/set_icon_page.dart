import 'package:quiz_me/main/imports.dart';

class SetIconPage extends StatelessWidget {
  const SetIconPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Select Icon',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Icon that represent your study guide',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: h(10)),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: provider.icons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final icon = provider.icons[index];
                      return InkWell(
                        onTap: () => provider.changeIconSelection(icon),
                        child: Container(
                          height: h(48),
                          width: h(48),
                          padding: gapAll(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: icon.iconColor.withOpacity(0.1),
                            border: icon.selected
                                ? Border.all(width: w(2), color: icon.iconColor)
                                : Border.all(
                                    width: w(2),
                                    color: icon.iconColor.withOpacity(0),
                                  ),
                          ),
                          child: SvgPicture.asset(
                            icon.iconPath,
                            height: h(48),
                            colorFilter: ColorFilter.mode(
                              icon.iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      );
                    },
                  )
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
                onPressed: () async {
                  await provider.processGuideDetails();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
