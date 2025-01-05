import 'package:quiz_me/main/imports.dart';

class FlashcardSwapper extends StatelessWidget {
  final Function(int, int, SwiperActivity) swipeEnd;
  final Function() onEnd;
  final String title;
  const FlashcardSwapper({
    super.key,
    required this.title,
    required this.swipeEnd,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: w(340),
        height: h(575),
        child: AppinioSwiper(
          invertAngleOnBottomDrag: true,
          backgroundCardCount: 0,
          onSwipeEnd: swipeEnd,
          onEnd: onEnd,
          swipeOptions: const SwipeOptions.symmetric(horizontal: true),
          controller: provider.controller,
          onCardPositionChanged: (position) {},
          cardCount: provider.results.length,
          cardBuilder: (context, index) {
            final cardKey = GlobalKey<FlipCardState>();
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).cardColor,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: w(2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                    contentPadding: gapZero,
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    title: Padding(
                      padding: gapSymmetric(horizontal: 12),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cardKey.currentState!.toggleCard();
                    },
                    child: FlipCard(
                      key: cardKey,
                      flipOnTouch: false,
                      direction: FlipDirection.VERTICAL,
                      front: Padding(
                        padding: gapAll(16),
                        child: Text(
                          provider.results[index].question,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: h(30), fontWeight: FontWeight.w300),
                        ),
                      ),
                      back: Padding(
                        padding: gapAll(16),
                        child: Text(
                          provider.results[index].answer,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: h(30),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Tap to flip for answer 👆🏻',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
