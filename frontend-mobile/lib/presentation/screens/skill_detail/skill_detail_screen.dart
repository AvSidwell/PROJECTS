import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/section_header.dart';
import '../../../domain/entities/skill.dart';
import '../../providers/progress_provider.dart';
import '../../providers/skill_provider.dart';

class SkillDetailScreen extends ConsumerWidget {
  const SkillDetailScreen({super.key, required this.skillId});

  final String skillId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillAsync = ref.watch(skillByIdProvider(skillId));

    return skillAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (skill) {
        if (skill == null) {
          return const Scaffold(body: Center(child: Text('Skill not found')));
        }
        return _SkillDetailContent(skill: skill);
      },
    );
  }
}

class _SkillDetailContent extends ConsumerWidget {
  const _SkillDetailContent({required this.skill});

  final Skill skill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider(skill.id)).value;

    final completedCount = progress?.completedStageIds.length ?? 0;
    final isComingSoon = skill.status == SkillStatus.comingSoon;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _HeroSliver(skill: skill),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            sliver: SliverList.list(children: [
              if (!isComingSoon) ...[
                Text(
                  '$completedCount of ${skill.stages.length} stages complete',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.accent),
                ),
                const SizedBox(height: AppSpacing.sectionGap),
              ],
              Text(skill.description, style: AppTypography.bodyLarge),
              const SizedBox(height: AppSpacing.sectionGap),
              Text(
                'Why it\'s hard',
                style: AppTypography.labelSmall.copyWith(color: AppColors.warning),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(skill.whyItsHard, style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.sectionGap),
              Text(
                'Prerequisites',
                style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...skill.prerequisites.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '—',
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textTertiary),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                          child: Text(item, style: AppTypography.bodyMedium)),
                    ],
                  ),
                ),
              ),
              if (!isComingSoon) ...[
                const SizedBox(height: AppSpacing.sectionGap),
                SectionHeader(
                  title: 'Progression Stages',
                  action: () => context.push('/skills/${skill.id}/progression'),
                  actionLabel: 'View all',
                ),
                const SizedBox(height: AppSpacing.md),
                ...skill.stages.take(3).map(
                      (s) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _StagePreviewRow(
                          stage: s,
                          isCompleted: progress?.isStageCompleted(s.id) ?? false,
                        ),
                      ),
                    ),
                if (skill.stages.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: GestureDetector(
                      onTap: () =>
                          context.push('/skills/${skill.id}/progression'),
                      child: Text(
                        '+ ${skill.stages.length - 3} more stages',
                        style: AppTypography.labelMedium
                            .copyWith(color: AppColors.textTertiary),
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.sectionGap),
                SectionHeader(
                  title: 'Common Hurdles',
                  action: () => context.push('/skills/${skill.id}/hurdles'),
                  actionLabel: 'See fixes',
                ),
                const SizedBox(height: AppSpacing.md),
                ...skill.hurdles.take(3).map(
                      (h) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _HurdlePreviewRow(title: h.title),
                      ),
                    ),
                const SizedBox(height: AppSpacing.sectionGap),
                AppButton(
                  label: 'Start Today\'s Practice',
                  onTap: () => context.push('/skills/${skill.id}/practice'),
                  icon: Icons.play_arrow_rounded,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'View Full Progression',
                  onTap: () => context.push('/skills/${skill.id}/progression'),
                  variant: AppButtonVariant.secondary,
                ),
              ],
              const SizedBox(height: AppSpacing.xxl),
            ]),
          ),
        ],
      ),
    );
  }
}

class _HeroSliver extends StatelessWidget {
  const _HeroSliver({required this.skill});

  final Skill skill;

  Color get _difficultyColor => switch (skill.difficulty) {
        SkillDifficulty.beginner => AppColors.success,
        SkillDifficulty.intermediate => AppColors.warning,
        SkillDifficulty.advanced => AppColors.error,
      };

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.surface,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.xxl,
                AppSpacing.screenPadding,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    skill.difficultyLabel.toUpperCase(),
                    style: AppTypography.labelSmall.copyWith(
                      color: _difficultyColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(skill.name, style: AppTypography.displayMedium),
                  const SizedBox(height: 4),
                  Text(skill.subtitle, style: AppTypography.bodyMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StagePreviewRow extends StatelessWidget {
  const _StagePreviewRow({required this.stage, required this.isCompleted});

  final dynamic stage;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Text(
              stage.order.toString().padLeft(2, '0'),
              style: AppTypography.headingMedium.copyWith(
                color: isCompleted ? AppColors.success : AppColors.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.name,
                  style: AppTypography.headingSmall.copyWith(
                    color: isCompleted ? AppColors.success : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(stage.goal, style: AppTypography.bodySmall),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check, size: 14, color: AppColors.success),
        ],
      ),
    );
  }
}

class _HurdlePreviewRow extends StatelessWidget {
  const _HurdlePreviewRow({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: AppTypography.bodyMedium),
        ),
        const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
      ],
    );
  }
}
