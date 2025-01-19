import 'package:quiz_me/main/imports.dart';

enum _RadioType { material, adaptive }

class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.secondary,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.autofocus = false,
    this.contentPadding,
    this.shape,
    this.tileColor,
    this.selectedTileColor,
    this.visualDensity,
    this.focusNode,
    this.onFocusChange,
    this.enableFeedback,
  })  : _radioType = _RadioType.material,
        useCupertinoCheckmarkStyle = false,
        assert(!isThreeLine || subtitle != null);

  const CustomRadioListTile.adaptive({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.secondary,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.autofocus = false,
    this.contentPadding,
    this.shape,
    this.tileColor,
    this.selectedTileColor,
    this.visualDensity,
    this.focusNode,
    this.onFocusChange,
    this.enableFeedback,
    this.useCupertinoCheckmarkStyle = false,
  })  : _radioType = _RadioType.adaptive,
        assert(!isThreeLine || subtitle != null);

  final T value;

  
  final T? groupValue;

  final ValueChanged<T?>? onChanged;

  final MouseCursor? mouseCursor;

  final bool toggleable;

  final Color? activeColor;

  final WidgetStateProperty<Color?>? fillColor;

  final MaterialTapTargetSize? materialTapTargetSize;

  final Color? hoverColor;

  final WidgetStateProperty<Color?>? overlayColor;

  final double? splashRadius;

  final Widget? title;

  final Widget? subtitle;

  final Widget? secondary;

  final bool isThreeLine;

  final bool? dense;

  final bool selected;

  final ListTileControlAffinity controlAffinity;

  final bool autofocus;

  final EdgeInsetsGeometry? contentPadding;

  bool get checked => value == groupValue;

  final ShapeBorder? shape;

  final Color? tileColor;

  final Color? selectedTileColor;

  final VisualDensity? visualDensity;

  final FocusNode? focusNode;

  final ValueChanged<bool>? onFocusChange;

  final bool? enableFeedback;

  final _RadioType _radioType;

  final bool useCupertinoCheckmarkStyle;

  @override
  Widget build(BuildContext context) {
    final Widget control;
    switch (_radioType) {
      case _RadioType.material:
        control = ExcludeFocus(
          child: Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            toggleable: toggleable,
            activeColor: activeColor,
            materialTapTargetSize:
                materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
            autofocus: autofocus,
            fillColor: fillColor,
            mouseCursor: mouseCursor,
            hoverColor: hoverColor,
            overlayColor: overlayColor,
            splashRadius: splashRadius,
          ),
        );
      case _RadioType.adaptive:
        control = ExcludeFocus(
          child: Radio<T>.adaptive(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            toggleable: toggleable,
            activeColor: activeColor,
            materialTapTargetSize:
                materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
            autofocus: autofocus,
            fillColor: fillColor,
            mouseCursor: mouseCursor,
            hoverColor: hoverColor,
            overlayColor: overlayColor,
            splashRadius: splashRadius,
            useCupertinoCheckmarkStyle: useCupertinoCheckmarkStyle,
          ),
        );
    }

    Widget? leading, trailing;
    (leading, trailing) = switch (controlAffinity) {
      ListTileControlAffinity.leading || ListTileControlAffinity.platform => (
          control,
          secondary
        ),
      ListTileControlAffinity.trailing => (secondary, control),
    };
    final ThemeData theme = Theme.of(context);
    final RadioThemeData radioThemeData = RadioTheme.of(context);
    final Set<WidgetState> states = <WidgetState>{
      if (selected) WidgetState.selected,
    };
    final Color effectiveActiveColor = activeColor ??
        radioThemeData.fillColor?.resolve(states) ??
        theme.colorScheme.secondary;
    return MergeSemantics(
      child: ListTile(
        selectedColor: effectiveActiveColor,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        isThreeLine: isThreeLine,
        dense: dense,
        enabled: onChanged != null,
        shape: shape,
        tileColor: tileColor,
        selectedTileColor: selectedTileColor,
        onTap: onChanged != null
            ? () {
                if (toggleable && checked) {
                  onChanged!(null);
                  return;
                }
                if (!checked) {
                  onChanged!(value);
                }
              }
            : null,
        selected: selected,
        autofocus: autofocus,
        contentPadding: contentPadding,
        visualDensity: visualDensity,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        enableFeedback: enableFeedback,
      ),
    );
  }
}
