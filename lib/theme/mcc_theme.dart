import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MCCColors {
  // ── Charte officielle PDF ──────────────────────────────
  static const Color red        = Color(0xFFE31B18);
  static const Color green      = Color(0xFF009B72);
  static const Color yellow     = Color(0xFFFFD605);
  static const Color redDark    = Color(0xFF531013);
  static const Color greenDark  = Color(0xFF0E3529);
  static const Color goldDark   = Color(0xFF544718);
 
  // ── Tints utiles ──────────────────────────────────────
  static const Color redTint    = Color(0xFFFFF0F0);
  static const Color greenTint  = Color(0xFFEDF7F4);
  static const Color yellowTint = Color(0xFFFFFBE6);
 
  // ── Fond & surfaces ───────────────────────────────────
  static const Color white      = Color(0xFFFFFFFF);
  static const Color bg         = Color(0xFFFFFFFF);
  static const Color bgSoft     = Color(0xFFF7F7F7);
  static const Color bgCard     = Color(0xFFFAFAFA);
  static const Color border     = Color(0xFFEEEEEE);
  static const Color borderMid  = Color(0xFFDDDDDD);
 
  // ── Textes ────────────────────────────────────────────
  static const Color ink        = Color(0xFF111111);
  static const Color inkMid     = Color(0xFF444444);
  static const Color muted      = Color(0xFF888888);
  static const Color mutedLight = Color(0xFFBBBBBB);
}
 
class MCCTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: MCCColors.bg,
    primaryColor: MCCColors.red,
    colorScheme: const ColorScheme.light(
      primary:      MCCColors.red,
      secondary:    MCCColors.green,
      tertiary:     MCCColors.yellow,
      surface:      MCCColors.bgCard,
      background:   MCCColors.bg,
      onPrimary:    MCCColors.white,
      onSecondary:  MCCColors.white,
      onSurface:    MCCColors.ink,
      onBackground: MCCColors.ink,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(
      bodyColor:    MCCColors.ink,
      displayColor: MCCColors.ink,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor:    MCCColors.white,
      elevation:          0,
      scrolledUnderElevation: 0,
      centerTitle:        false,
      surfaceTintColor:   Colors.transparent,
      titleTextStyle: GoogleFonts.cormorantGaramond(
        fontSize: 22, fontWeight: FontWeight.w500,
        color: MCCColors.ink, letterSpacing: 0.3,
      ),
      iconTheme: const IconThemeData(color: MCCColors.ink),
      actionsIconTheme: const IconThemeData(color: MCCColors.inkMid),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled:       true,
      fillColor:    MCCColors.bgSoft,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MCCColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MCCColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MCCColors.red, width: 1.5),
      ),
      hintStyle: GoogleFonts.poppins(
        fontSize: 13, color: MCCColors.mutedLight, fontWeight: FontWeight.w300,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MCCColors.red,
        foregroundColor: MCCColors.white,
        elevation:       0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.poppins(
          fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.2,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MCCColors.red,
        side: const BorderSide(color: MCCColors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.poppins(
          fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.2,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: MCCColors.border, thickness: 1, space: 0,
    ),
    cardTheme: CardThemeData(
      color:     MCCColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: MCCColors.border),
      ),
      margin: EdgeInsets.zero,
    ),
  );
}
 