import 'package:flutter/material.dart';
import 'package:quiz_me/core/global/functions/gap.dart';
import 'package:quiz_me/core/global/functions/resize.dart';

AnimatedContainer buildDot(context, int index, int currentPage) {
  double baseHeight = h(4);
  double baseWidth = w(4);
  double selectedWidth = w(16);

  if (screenHeight > 360) {
    baseHeight = h(5);
    baseWidth = w(5);
    selectedWidth = w(20);
  }

  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: gapOnly(right: 5),
    height: baseHeight,
    width: currentPage == index ? selectedWidth : baseWidth,
    decoration: BoxDecoration(
      color: currentPage == index
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColor.withOpacity(0.25),
      borderRadius: BorderRadius.circular(baseHeight / 2),
    ),
  );
}
