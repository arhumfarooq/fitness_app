import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/exports.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  /// Compatibility light theme retained while existing screens are migrated.
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.cardLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgLight,
      colorScheme: scheme,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.borderLight,
          disabledForegroundColor: AppColors.textMuted,
          minimumSize: const Size(
            AppSizes.minTouchTarget,
            AppSizes.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
          textStyle: AppTextStyles.label,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        fillColor: AppColors.cardLight,
        enabledBorder: AppColors.borderLight,
        hintColor: const Color(0xFF6B7280),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          side: const BorderSide(color: AppColors.borderLight),
        ),
      ),
    );
  }

  /// Premium dark theme for Fitness AI Design Language v1.
  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.brandPrimary,
      onPrimary: AppColors.onBrand,
      primaryContainer: AppColors.activityContainer,
      onPrimaryContainer: AppColors.brandPrimary,
      secondary: AppColors.aiPurple,
      onSecondary: AppColors.background,
      secondaryContainer: AppColors.aiContainer,
      onSecondaryContainer: AppColors.aiPurple,
      tertiary: AppColors.hydrationBlue,
      onTertiary: AppColors.background,
      tertiaryContainer: AppColors.hydrationContainer,
      onTertiaryContainer: AppColors.hydrationBlue,
      error: AppColors.dangerRed,
      onError: AppColors.background,
      errorContainer: AppColors.dangerContainer,
      onErrorContainer: AppColors.dangerRed,
      surface: AppColors.surface1,
      onSurface: AppColors.textPrimary,
      surfaceContainerLowest: AppColors.background,
      surfaceContainerLow: AppColors.surface1,
      surfaceContainer: AppColors.surface2,
      surfaceContainerHigh: AppColors.surface3,
      surfaceContainerHighest: AppColors.borderSubtle,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.borderInteractive,
      outlineVariant: AppColors.borderSubtle,
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: AppColors.textPrimary,
      onInverseSurface: AppColors.background,
      inversePrimary: Color(0xFF536D24),
    );

    final textTheme =
        TextTheme(
          displayLarge: AppTextStyles.headingLarge,
          displayMedium: AppTextStyles.headingLarge,
          displaySmall: AppTextStyles.headingMedium,
          headlineLarge: AppTextStyles.headingLarge,
          headlineMedium: AppTextStyles.headingMedium,
          headlineSmall: AppTextStyles.title,
          titleLarge: AppTextStyles.headingMedium,
          titleMedium: AppTextStyles.title,
          titleSmall: AppTextStyles.label,
          bodyLarge: AppTextStyles.body,
          bodyMedium: AppTextStyles.bodySmall,
          bodySmall: AppTextStyles.caption,
          labelLarge: AppTextStyles.label,
          labelMedium: AppTextStyles.label,
          labelSmall: AppTextStyles.caption,
        ).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      disabledColor: AppColors.textDisabled,
      focusColor: AppColors.brandPrimary.withValues(alpha: 0.18),
      hoverColor: AppColors.brandPrimary.withValues(alpha: 0.08),
      splashColor: AppColors.brandPrimary.withValues(alpha: 0.12),
      highlightColor: AppColors.brandPrimary.withValues(alpha: 0.08),
      textTheme: textTheme,
      primaryTextTheme: textTheme,

      cardTheme: CardThemeData(
        color: AppColors.surface1,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          side: const BorderSide(color: AppColors.borderSubtle),
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: AppSizes.appHeaderHeight,
        titleTextStyle: AppTextStyles.headingMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
        actionsIconTheme: const IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: AppSizes.bottomNavHeight,
        backgroundColor: AppColors.surface1,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        indicatorColor: AppColors.activityContainer,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppColors.brandPrimary : AppColors.textMuted,
            size: 24,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return AppTextStyles.caption.copyWith(
            color: selected ? AppColors.textPrimary : AppColors.textMuted,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          );
        }),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface1,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.brandPrimary,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: AppTextStyles.caption,
        unselectedLabelStyle: AppTextStyles.caption,
        showUnselectedLabels: true,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(AppSizes.minTouchTarget, AppSizes.buttonHeight),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppSizes.space5),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.borderStrong;
            }
            return AppColors.brandPrimary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textDisabled;
            }
            return AppColors.onBrand;
          }),
          overlayColor: WidgetStatePropertyAll(
            AppColors.onBrand.withValues(alpha: 0.10),
          ),
          elevation: const WidgetStatePropertyAll(0),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(buttonShape),
          textStyle: WidgetStatePropertyAll(AppTextStyles.label),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(AppSizes.minTouchTarget, AppSizes.buttonHeight),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppSizes.space5),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.surface3;
            }
            return AppColors.surface2;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textDisabled;
            }
            return AppColors.textPrimary;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return const BorderSide(color: AppColors.brandPrimary, width: 2);
            }
            return BorderSide(
              color: states.contains(WidgetState.disabled)
                  ? AppColors.borderSubtle
                  : AppColors.borderStrong,
            );
          }),
          shape: WidgetStatePropertyAll(buttonShape),
          textStyle: WidgetStatePropertyAll(AppTextStyles.label),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(AppSizes.minTouchTarget, AppSizes.minTouchTarget),
          ),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textDisabled;
            }
            return AppColors.brandPrimary;
          }),
          overlayColor: WidgetStatePropertyAll(
            AppColors.brandPrimary.withValues(alpha: 0.10),
          ),
          shape: WidgetStatePropertyAll(buttonShape),
          textStyle: WidgetStatePropertyAll(AppTextStyles.label),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size.square(AppSizes.minTouchTarget),
          ),
          iconSize: const WidgetStatePropertyAll(24),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textDisabled;
            }
            return AppColors.textPrimary;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.surface3;
            }
            return Colors.transparent;
          }),
          overlayColor: WidgetStatePropertyAll(
            AppColors.brandPrimary.withValues(alpha: 0.10),
          ),
          shape: WidgetStatePropertyAll(buttonShape),
        ),
      ),

      inputDecorationTheme: _inputTheme(
        fillColor: AppColors.surface1,
        enabledBorder: AppColors.borderInteractive,
        hintColor: AppColors.textMuted,
      ),

      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: AppColors.borderInteractive, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall / 2),
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.borderStrong;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.brandPrimary;
          }
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(AppColors.onBrand),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.onBrand;
          }
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.borderSubtle;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.brandPrimary;
          }
          return AppColors.borderStrong;
        }),
        trackOutlineColor: const WidgetStatePropertyAll(
          AppColors.borderInteractive,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.brandPrimary,
        linearTrackColor: AppColors.borderSubtle,
        circularTrackColor: AppColors.borderSubtle,
        linearMinHeight: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface2,
        selectedColor: AppColors.activityContainer,
        disabledColor: AppColors.surface1,
        checkmarkColor: AppColors.brandPrimary,
        labelStyle: AppTextStyles.caption.copyWith(
          color: AppColors.textSecondary,
        ),
        secondaryLabelStyle: AppTextStyles.caption.copyWith(
          color: AppColors.textPrimary,
        ),
        side: const BorderSide(color: AppColors.borderStrong),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space2),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface3,
        contentTextStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textPrimary,
        ),
        actionTextColor: AppColors.brandPrimary,
        disabledActionTextColor: AppColors.textDisabled,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          side: const BorderSide(color: AppColors.borderStrong),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface3,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: AppTextStyles.headingMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        contentTextStyle: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          side: const BorderSide(color: AppColors.borderStrong),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface3,
        modalBackgroundColor: AppColors.surface3,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        showDragHandle: true,
        dragHandleColor: AppColors.borderInteractive,
        dragHandleSize: Size(40, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusExtraLarge),
          ),
          side: BorderSide(color: AppColors.borderStrong),
        ),
      ),
    );
  }

  static InputDecorationTheme _inputTheme({
    required Color fillColor,
    required Color enabledBorder,
    required Color hintColor,
  }) {
    OutlineInputBorder border(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      constraints: const BoxConstraints(minHeight: AppSizes.fieldHeight),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space4,
        vertical: AppSizes.space3,
      ),
      hintStyle: AppTextStyles.body.copyWith(color: hintColor),
      labelStyle: AppTextStyles.label,
      helperStyle: AppTextStyles.caption,
      errorStyle: AppTextStyles.caption.copyWith(color: AppColors.dangerRed),
      border: border(enabledBorder),
      enabledBorder: border(enabledBorder),
      disabledBorder: border(AppColors.borderSubtle),
      focusedBorder: border(AppColors.brandPrimary, width: 2),
      errorBorder: border(AppColors.dangerRed),
      focusedErrorBorder: border(AppColors.dangerRed, width: 2),
    );
  }
}
