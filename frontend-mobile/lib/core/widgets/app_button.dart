import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isFullWidth = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isFullWidth;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (variant) {
      AppButtonVariant.primary => (AppColors.accent, const Color(0xFF0D1220)),
      AppButtonVariant.secondary => (AppColors.card, AppColors.accent),
      AppButtonVariant.ghost => (Colors.transparent, AppColors.textSecondary),
    };

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 15),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: fg,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: fg, size: 18),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(label, style: AppTypography.buttonPrimary.copyWith(color: fg)),
                ],
              ),
      ),
    );
  }
}
