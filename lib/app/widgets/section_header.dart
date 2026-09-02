import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Header seksi standar dengan judul dan opsional tombol aksi "Lihat Semua".
/// Digunakan di seluruh view B2C, B2B, dan Teknisi agar tampilan konsisten.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionTitle;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionTitle,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkSlate,
          ),
        ),
        if (actionTitle != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionTitle!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
