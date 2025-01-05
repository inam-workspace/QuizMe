import 'package:quiz_me/main/imports.dart';

class NavigationAnimation extends PageRouteBuilder {
  final Widget page;
  @override
  final RouteSettings settings;

  NavigationAnimation({required this.page, required this.settings})
      : super(
          reverseTransitionDuration: const Duration(milliseconds: 375),
          transitionDuration: const Duration(milliseconds: 375),
          maintainState: true,
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ));

            final reverseOffsetAnimation = Tween<Offset>(
              end: Offset.zero,
              begin: const Offset(-1.0, 0.0),
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            );
            return SlideTransition(
              position: animation.status == AnimationStatus.reverse
                  ? reverseOffsetAnimation
                  : offsetAnimation,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: child,
              ),
            );
          },
        );
}
