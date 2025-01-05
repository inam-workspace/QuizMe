import 'package:quiz_me/main/imports.dart';

EdgeInsets get gapZero => EdgeInsets.zero;

EdgeInsets gapAll(double? size) => EdgeInsets.fromLTRB(
      w(size),
      h(size),
      h(size),
      w(size),
    );

EdgeInsets gapSymmetric({
  double? horizontal,
  double? vertical,
}) =>
    EdgeInsets.symmetric(
      horizontal: w(horizontal ?? 0),
      vertical: h(vertical ?? 0),
    );

EdgeInsets gapOnly({
  double? left,
  double? top,
  double? right,
  double? bottom,
}) =>
    EdgeInsets.fromLTRB(
      w(left ?? 0),
      h(top ?? 0),
      w(right ?? 0),
      h(bottom ?? 0),
    );
