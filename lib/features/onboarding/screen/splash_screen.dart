import 'package:quiz_me/main/imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Container(
      decoration: BoxDecoration(gradient: AppColors.gradient),
      child: Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              bottom: h(200),
              child: SvgPicture.asset(
                'assets/images/background.svg',
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h(100),
                    width: h(100),
                    child: SvgPicture.asset(
                      'assets/images/icon_logo.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).scaffoldBackgroundColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(height: h(20)),
                  SvgPicture.asset(
                    'assets/images/text_logo.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).scaffoldBackgroundColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
