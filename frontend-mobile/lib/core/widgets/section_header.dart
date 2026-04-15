import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.actionLabel,
  });

  final String title;
  final VoidCallback? action;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(title, style: AppTypography.headingMedium),
        if (action != null)
          GestureDetector(
            onTap: action,
            child: Text(
              actionLabel ?? 'See all',
              style: AppTypography.labelSmall.copyWith(color: AppColors.accent),
            ),
          ),
      ],
    );
  }
}
