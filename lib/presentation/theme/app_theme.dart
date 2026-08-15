import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import 'app_text_styles.dart';

/// Central Material theme for the GYMORA AI visual language.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildTheme(dark: false);
  static ThemeData get dark => _buildTheme(dark: true);

  static ThemeData _buildTheme({required bool dark}) {
    final primary = dark ? AppColors.darkBrandPrimary : AppColors.brandPrimary;
    final onPrimary = dark ? AppColors.darkOnBrand : AppColors.onBrand;
    final background = dark ? AppColors.darkBackground : AppColors.background;
    final surface1 = dark ? AppColors.darkSurface1 : AppColors.surface1;
    final surface2 = dark ? AppColors.darkSurface2 : AppColors.surface2;
    final surface3 = dark ? AppColors.darkSurface3 : AppColors.surface3;
    final border = dark ? AppColors.darkBorderSubtle : AppColors.borderSubtle;
    final borderStrong = dark
        ? AppColors.darkBorderStrong
        : AppColors.borderStrong;
    final focusBorder = dark
        ? AppColors.darkBorderInteractive
        : AppColors.borderInteractive;
    final text = dark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = dark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;
    final mutedText = dark ? AppColors.darkTextMuted : AppColors.textMuted;
    final disabledText = dark
        ? AppColors.darkTextDisabled
        : AppColors.textDisabled;
    final error = dark ? AppColors.darkDangerRed : AppColors.dangerRed;
    final info = dark
        ? AppColors.darkHydrationBlue
        : AppColors.hydrationRecovery;
    final onSurface = text;

    final scheme = dark
        ? ColorScheme.dark(
            primary: primary,
            onPrimary: onPrimary,
            secondary: info,
            onSecondary: Colors.white,
            error: error,
            onError: Colors.white,
            surface: surface1,
            onSurface: onSurface,
            outline: borderStrong,
          )
        : ColorScheme.light(
            primary: primary,
            onPrimary: onPrimary,
            secondary: info,
            onSecondary: Colors.white,
            error: error,
            onError: Colors.white,
            surface: surface1,
            onSurface: onSurface,
            outline: borderStrong,
          );

    final textTheme =
        GoogleFonts.interTextTheme(
          dark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
        ).copyWith(
          displayLarge: AppTextStyles.displayMetric.copyWith(color: text),
          headlineLarge: AppTextStyles.headingLarge.copyWith(color: text),
          headlineMedium: AppTextStyles.headingMedium.copyWith(color: text),
          titleLarge: AppTextStyles.title.copyWith(color: text),
          bodyLarge: AppTextStyles.body.copyWith(color: text),
          bodyMedium: AppTextStyles.bodySmall.copyWith(color: secondaryText),
          labelLarge: AppTextStyles.label.copyWith(color: text),
          labelSmall: AppTextStyles.caption.copyWith(color: mutedText),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      cardTheme: CardThemeData(
        color: surface1,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          side: BorderSide(color: border),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.title.copyWith(color: text),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: AppSizes.bottomNavHeight,
        backgroundColor: surface1,
        elevation: 0,
        indicatorColor: dark
            ? AppColors.darkActivityContainer
            : AppColors.activityContainer,
        labelTextStyle: WidgetStatePropertyAll(
          AppTextStyles.caption.copyWith(color: secondaryText),
        ),
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(color: secondaryText, size: 22),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface1,
        selectedItemColor: primary,
        unselectedItemColor: secondaryText,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, AppSizes.buttonHeight),
          backgroundColor: primary,
          foregroundColor: onPrimary,
          disabledBackgroundColor: surface3,
          disabledForegroundColor: disabledText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
          textStyle: AppTextStyles.label,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, AppSizes.buttonHeight),
          foregroundColor: text,
          side: BorderSide(color: borderStrong),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
          textStyle: AppTextStyles.label,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(
            AppSizes.minTouchTarget,
            AppSizes.minTouchTarget,
          ),
          foregroundColor: primary,
          textStyle: AppTextStyles.label,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(
            AppSizes.minTouchTarget,
            AppSizes.minTouchTarget,
          ),
          foregroundColor: text,
          disabledForegroundColor: disabledText,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        fill: surface1,
        border: border,
        focus: focusBorder,
        text: text,
        hint: secondaryText,
        error: error,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? primary : null,
        ),
        checkColor: WidgetStatePropertyAll(onPrimary),
        side: BorderSide(color: borderStrong),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? primary : mutedText,
        ),
        trackColor: WidgetStatePropertyAll(surface3),
        trackOutlineColor: WidgetStatePropertyAll(borderStrong),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: surface3,
        circularTrackColor: surface3,
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
      chipTheme: ChipThemeData(
        backgroundColor: surface2,
        selectedColor: dark
            ? AppColors.darkActivityContainer
            : AppColors.activityContainer,
        side: BorderSide(color: border),
        labelStyle: AppTextStyles.caption.copyWith(color: text),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface2,
        contentTextStyle: AppTextStyles.bodySmall.copyWith(color: text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface1,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.headingMedium.copyWith(color: text),
        contentTextStyle: AppTextStyles.body.copyWith(color: secondaryText),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          side: BorderSide(color: border),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface1,
        modalBackgroundColor: surface1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusExtraLarge),
          ),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surface2,
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        ),
        textStyle: AppTextStyles.caption.copyWith(color: text),
      ),
    );
  }

  static InputDecorationTheme _inputTheme({
    required Color fill,
    required Color border,
    required Color focus,
    required Color text,
    required Color hint,
    required Color error,
  }) {
    OutlineInputBorder outline(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      constraints: const BoxConstraints(minHeight: AppSizes.fieldHeight),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space4,
        vertical: AppSizes.space3,
      ),
      hintStyle: AppTextStyles.body.copyWith(color: hint),
      labelStyle: AppTextStyles.bodySmall.copyWith(color: hint),
      enabledBorder: outline(border),
      focusedBorder: outline(focus, width: 2),
      errorBorder: outline(error),
      focusedErrorBorder: outline(error, width: 2),
    );
  }
}
