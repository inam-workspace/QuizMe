class IconDetailsEntity {
  final String iconPath;
  final String iconColor;

  IconDetailsEntity({required this.iconColor, required this.iconPath});

  Map toJson() {
    return {
      "icon_path": iconPath,
      "icon_color": iconColor,
    };
  }

  static IconDetailsEntity fromJson(Map json) {
    return IconDetailsEntity(
      iconPath: json['icon_path'] as String,
      iconColor: json['icon_color'] as String,
    );
  }
}
