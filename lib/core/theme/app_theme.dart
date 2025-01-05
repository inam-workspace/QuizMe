import 'package:quiz_me/main/imports.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primarySwatch,
      hintColor: AppColors.hint,
      cardColor: AppColors.card,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      disabledColor: AppColors.disable,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.background,
        titleTextStyle: AppTextStyles.titleLarge,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        error: AppColors.error,
        scrim: AppColors.suface,
      ),
    );
  }
}
