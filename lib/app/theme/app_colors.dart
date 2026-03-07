import 'package:flutter/material.dart';

/// PartnerPro brand color palette.
/// Gold-primary theme inherited from the original app, modernized.
abstract final class AppColors {
  // ── Brand ──
  static const Color primary = Color(0xFFD0B27D);       // Warm gold
  static const Color primaryDark = Color(0xFF998053);    // Deep gold
  static const Color secondary = Color(0xFF0070E0);      // Vibrant blue
  static const Color secondaryDark = Color(0xFF0544B5);  // Deep blue
  static const Color tertiary = Color(0xFFEE8B60);       // Coral accent

  // ── Surfaces ──
  static const Color background = Color(0xFFF7F8FA);     // Slightly warmer than pure white
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F4F8);
  static const Color card = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE8ECF0);
  static const Color border = Color(0xFFE0E3E7);

  // ── Text ──
  static const Color textPrimary = Color(0xFF14181B);
  static const Color textSecondary = Color(0xFF57636C);
  static const Color textTertiary = Color(0xFF95A1AC);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ── Status ──
  static const Color success = Color(0xFF249689);
  static const Color warning = Color(0xFFF9CF58);
  static const Color error = Color(0xFFFF5963);
  static const Color info = Color(0xFF0070E0);

  // ── Gradient ──
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD0B27D), Color(0xFF998053)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF14181B), Color(0xFF2D3436)],
  );

  // ── Shimmer ──
  static const Color shimmerBase = Color(0xFFE0E3E7);
  static const Color shimmerHighlight = Color(0xFFF1F4F8);

  // ── Dark Mode ──
  static const Color darkBackground = Color(0xFF14181B);
  static const Color darkSurface = Color(0xFF1E2429);
  static const Color darkCard = Color(0xFF262D34);
  static const Color darkDivider = Color(0xFF393E46);
  static const Color darkTextPrimary = Color(0xFFF1F4F8);
  static const Color darkTextSecondary = Color(0xFF95A1AC);
}
