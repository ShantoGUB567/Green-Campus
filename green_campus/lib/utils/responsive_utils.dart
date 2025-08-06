import 'package:flutter/material.dart';

class ResponsiveUtils {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getResponsiveFontSize(BuildContext context, double percentage) {
    final screenWidth = getScreenWidth(context);
    return screenWidth * percentage;
  }

  static double getResponsiveSize(BuildContext context, double percentage) {
    final screenWidth = getScreenWidth(context);
    return screenWidth * percentage;
  }

  static double getResponsiveHeight(BuildContext context, double percentage) {
    final screenHeight = getScreenHeight(context);
    return screenHeight * percentage;
  }

  static EdgeInsets getResponsivePadding(BuildContext context, {
    double horizontalPercentage = 0.1,
    double verticalPercentage = 0.05,
  }) {
    return EdgeInsets.symmetric(
      horizontal: getScreenWidth(context) * horizontalPercentage,
      vertical: getScreenHeight(context) * verticalPercentage,
    );
  }

  static double clampValue(double value, double min, double max) {
    return value.clamp(min, max);
  }

  // Device type detection
  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return getScreenWidth(context) >= 1200;
  }

  // Responsive text styles
  static TextStyle getResponsiveTextStyle(
    BuildContext context, {
    double fontSizePercentage = 0.04,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? minFontSize,
    double? maxFontSize,
  }) {
    final fontSize = getResponsiveFontSize(context, fontSizePercentage);
    final minSize = minFontSize ?? fontSize * 0.5;
    final maxSize = maxFontSize ?? fontSize * 1.5;

    return TextStyle(
      fontSize: clampValue(fontSize, minSize, maxSize),
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Responsive spacing
  static double getResponsiveSpacing(BuildContext context, double percentage) {
    return getScreenHeight(context) * percentage;
  }

  // Responsive icon size
  static double getResponsiveIconSize(BuildContext context, double percentage) {
    return getResponsiveSize(context, percentage);
  }
} 