import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Badge status standar — digunakan di seluruh view B2C, B2B, dan Teknisi.
/// Warna default: emerald (hijau) sesuai design system.
class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.text,
    this.backgroundColor = AppTheme.emerald50,
    this.textColor = AppTheme.primaryColor,
  });

  /// Factory shortcut untuk status bahaya / error
  factory StatusBadge.danger(String text) => StatusBadge(
        text: text,
        backgroundColor: AppTheme.dangerBackground,
        textColor: AppTheme.dangerColor,
      );

  /// Factory shortcut untuk status peringatan / warning
  factory StatusBadge.warning(String text) => StatusBadge(
        text: text,
        backgroundColor: AppTheme.warningBackground,
        textColor: AppTheme.warningColor,
      );

  /// Factory shortcut untuk status info / biru
  factory StatusBadge.info(String text) => StatusBadge(
        text: text,
        backgroundColor: const Color(0xFFEFF6FF),
        textColor: AppTheme.infoColor,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
