import 'package:flutter/material.dart';
import '../../domain/entities/drill.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class DrillCard extends StatefulWidget {
  const DrillCard({
    super.key,
    required this.drill,
    this.isChecked = false,
    this.onChecked,
    this.showCheckbox = false,
  });

  final Drill drill;
  final bool isChecked;
  final ValueChanged<bool>? onChecked;
  final bool showCheckbox;

  @override
  State<DrillCard> createState() => _DrillCardState();
}

class _DrillCardState extends State<DrillCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: widget.isChecked ? AppColors.surface : AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  if (widget.showCheckbox) ...[
                    GestureDetector(
                      onTap: () => widget.onChecked?.call(!widget.isChecked),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: widget.isChecked ? AppColors.accent : Colors.transparent,
                          border: Border.all(
                            color: widget.isChecked
                                ? AppColors.accent
                                : AppColors.textTertiary,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: widget.isChecked
                            ? const Icon(Icons.check, size: 13, color: Color(0xFF0D1220))
                            : null,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.drill.name,
                          style: AppTypography.headingSmall.copyWith(
                            color: widget.isChecked
                                ? AppColors.textTertiary
                                : AppColors.textPrimary,
                            decoration: widget.isChecked
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.drill.sets}  ·  ${widget.drill.reps}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.textTertiary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _DrillDetails(drill: widget.drill),
            crossFadeState:
                _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

class _DrillDetails extends StatelessWidget {
  const _DrillDetails({required this.drill});

  final Drill drill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.surface),
          const SizedBox(height: AppSpacing.md),
          Text(drill.description, style: AppTypography.bodyMedium),
          if (drill.steps.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            ...drill.steps.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${e.key + 1}.',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(e.value, style: AppTypography.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
          if (drill.tip != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '↑ ${drill.tip!}',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.warning,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
