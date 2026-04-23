import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_notifier/state_notifier.dart';

enum AppTheme { original, pandaRojo }

class AppThemeColors {
  final Color bg;
  final Color headerBg;
  final Color accent;
  final Color accentFg;
  final Color text;
  final Color muted;
  final Color userBubble;
  final Color userBubbleFg;
  final Color aiBubble;
  final Color aiBubbleFg;
  final Color inputBg;
  final Color inputBorder;
  final Color divider;
  final IconData icon;
  final String label;

  const AppThemeColors({
    required this.bg,
    required this.headerBg,
    required this.accent,
    required this.accentFg,
    required this.text,
    required this.muted,
    required this.userBubble,
    required this.userBubbleFg,
    required this.aiBubble,
    required this.aiBubbleFg,
    required this.inputBg,
    required this.inputBorder,
    required this.divider,
    required this.icon,
    required this.label,
  });
}

// Colores Tema Original
const _themeOriginalBoss = AppThemeColors(
  bg: Color(0xFF0E0E10),
  headerBg: Color(0xFF141416),
  accent: Color(0xFFE5C043),
  accentFg: Color(0xFF1A1200),
  text: Color(0xFFF0EDE4),
  muted: Color(0xFF7A7260),
  userBubble: Color(0xFFE5C043),
  userBubbleFg: Color(0xFF1A1200),
  aiBubble: Color(0xFF1E1E22),
  aiBubbleFg: Color(0xFFEDEAE0),
  inputBg: Color(0xFF1A1A1E),
  inputBorder: Color(0xFF2E2E36),
  divider: Color(0xFF222228),
  icon: Icons.bolt_outlined,
  label: 'Boss',
);

// Colores Tema Panda Rojo
const _themePandaRojo = AppThemeColors(
  bg: Color(0xFF0A0A0A),
  headerBg: Color(0xFF1A1A1A),
  accent: Color(0xFFC9302C),
  accentFg: Color(0xFFFFFFFF),
  text: Color(0xFFF5F5F5),
  muted: Color(0xFF808080),
  userBubble: Color(0xFFC9302C),
  userBubbleFg: Color(0xFFFFFFFF),
  aiBubble: Color(0xFF252525),
  aiBubbleFg: Color(0xFFEDEDED),
  inputBg: Color(0xFF161616),
  inputBorder: Color(0xFF2E2E2E),
  divider: Color(0xFF1F1F1F),
  icon: Icons.pets_outlined,
  label: 'Panda',
);

final appThemeProvider = StateNotifierProvider<AppThemeNotifier, AppTheme>(
  (ref) => AppThemeNotifier(),
);

class AppThemeNotifier extends StateNotifier<AppTheme> {
  AppThemeNotifier() : super(AppTheme.original);

  void setTheme(AppTheme theme) => state = theme;
}

AppThemeColors getThemeColors(AppTheme theme) {
  return theme == AppTheme.pandaRojo ? _themePandaRojo : _themeOriginalBoss;
}
