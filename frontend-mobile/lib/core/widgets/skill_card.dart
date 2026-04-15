import 'package:flutter/material.dart';
import '../../domain/entities/skill.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class SkillCard extends StatelessWidget {
  const SkillCard({
    super.key,
    required this.skill,
    this.progress = 0,
    this.completedStages = 0,
    this.onTap,
  });

  final Skill skill;
  final double progress;
  final int completedStages;
  final VoidCallback? onTap;

  Color get _difficultyColor => switch (skill.difficulty) {
        SkillDifficulty.beginner => AppColors.success,
        SkillDifficulty.intermediate => AppColors.warning,
        SkillDifficulty.advanced => AppColors.error,
      };

  @override
  Widget build(BuildContext context) {
    final isComingSoon = skill.status == SkillStatus.comingSoon;

    return GestureDetector(
      onTap: isComingSoon ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardPadding,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skill.difficultyLabel.toUpperCase(),
                    style: AppTypography.labelSmall.copyWith(
                      color: isComingSoon ? AppColors.stageLockedText : _difficultyColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    skill.name,
                    style: AppTypography.headingLarge.copyWith(
                      color: isComingSoon ? AppColors.textTertiary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    isComingSoon ? 'Coming soon' : skill.subtitle,
                    style: AppTypography.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!isComingSoon) ...[
                    const SizedBox(height: 14),
                    _ProgressBar(progress: progress),
                    const SizedBox(height: 6),
                    Text(
                      '$completedStages of ${skill.stages.length} stages',
                      style: AppTypography.caption,
                    ),
                  ],
                ],
              ),
            ),
            if (!isComingSoon) ...[
              const SizedBox(width: AppSpacing.md),
              Text(
                '${(progress * 100).round()}%',
                style: AppTypography.headingMedium.copyWith(
                  color: progress > 0 ? AppColors.accent : AppColors.textTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 2,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              height: 2,
              width: constraints.maxWidth * progress.clamp(0.0, 1.0),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        );
      },
    );
  }
}
