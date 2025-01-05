import 'package:quiz_me/main/imports.dart';

class TextThemes {
  static TextTheme get darkTextTheme {
    return TextTheme(
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.suface,
        fontSize: t(20),
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppColors.suface,
        fontSize: t(18),
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppColors.suface,
        fontSize: t(16),
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.suface,
        fontSize: t(16),
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.suface,
        fontSize: t(14),
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.suface,
        fontSize: t(12),
      ),
      labelLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.hint,
        fontSize: t(14),
      ),
      labelMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.hint,
        fontSize: t(12),
      ),
      labelSmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.hint,
        fontSize: t(10),
      ),
    );
  }

  /// Primary text theme
  static TextTheme get primaryTextTheme {
    return TextTheme(
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.primary,
        fontSize: t(20),
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppColors.primary,
        fontSize: t(18),
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppColors.primary,
        fontSize: t(16),
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.primary,
        fontSize: t(16),
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.primary,
        fontSize: t(14),
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.primary,
        fontSize: t(12),
      ),
      labelLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.primary.withOpacity(0.75),
        fontSize: t(14),
      ),
      labelMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.primary.withOpacity(0.75),
        fontSize: t(12),
      ),
      labelSmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.primary.withOpacity(0.75),
        fontSize: t(10),
      ),
    );
  }
}
