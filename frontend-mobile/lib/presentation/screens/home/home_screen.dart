import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skill_card.dart';
import '../../../data/seed/handstand_data.dart';
import '../../providers/progress_provider.dart';
import '../../providers/skill_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillsAsync = ref.watch(allSkillsProvider);
    final progressAsync = ref.watch(progressProvider(handstandSkill.id));

    return Scaffold(
      body: SafeArea(
        child: skillsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (skills) {
            final progress = progressAsync.value;

            if (progress == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref
                    .read(progressProvider(handstandSkill.id).notifier)
                    .initIfNeeded(handstandSkill.stages.first.id);
              });
            }

            final completedCount = progress?.completedStageIds.length ?? 0;
            final totalStages = handstandSkill.stages.length;
            final fraction = totalStages > 0 ? completedCount / totalStages : 0.0;

            final currentStageId =
                progress?.currentStageId ?? handstandSkill.stages.first.id;
            final currentStage = handstandSkill.stages.firstWhere(
              (s) => s.id == currentStageId,
              orElse: () => handstandSkill.stages.first,
            );

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding,
                      AppSpacing.lg,
                      AppSpacing.screenPadding,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Greeting(),
                        const SizedBox(height: AppSpacing.xxl),
                        _GoalSection(
                          stageName: currentStage.name,
                          stageNumber: currentStage.order,
                          totalStages: totalStages,
                          completedStages: completedCount,
                          progress: fraction,
                          onPractice: () =>
                              context.push('/skills/${handstandSkill.id}/practice'),
                          onViewPath: () =>
                              context.push('/skills/${handstandSkill.id}/progression'),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        _StatsStrip(
                          sessions: progress?.totalSessions ?? 0,
                          streak: progress?.practiceStreak ?? 0,
                          bestHold: progress?.bestHoldSeconds,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        SectionHeader(
                          title: 'Skills',
                          action: () => context.go('/skills'),
                          actionLabel: 'All skills',
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                  ),
                  sliver: SliverList.separated(
                    itemCount: skills.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm + 4),
                    itemBuilder: (_, i) {
                      final skill = skills[i];
                      final p = skill.id == handstandSkill.id ? fraction : 0.0;
                      final c = skill.id == handstandSkill.id ? completedCount : 0;
                      return SkillCard(
                        skill: skill,
                        progress: p,
                        completedStages: c,
                        onTap: () => context.push('/skills/${skill.id}'),
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
            ? 'Good afternoon'
            : 'Good evening';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting, style: AppTypography.bodyMedium),
        const SizedBox(height: 2),
        Text('Ready to train?', style: AppTypography.displayMedium),
      ],
    );
  }
}

class _GoalSection extends StatelessWidget {
  const _GoalSection({
    required this.stageName,
    required this.stageNumber,
    required this.totalStages,
    required this.completedStages,
    required this.progress,
    required this.onPractice,
    required this.onViewPath,
  });

  final String stageName;
  final int stageNumber;
  final int totalStages;
  final int completedStages;
  final double progress;
  final VoidCallback onPractice;
  final VoidCallback onViewPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CURRENT GOAL',
          style: AppTypography.labelSmall.copyWith(color: AppColors.accent),
        ),
        const SizedBox(height: 10),
        Text('Handstand', style: AppTypography.displayLarge),
        const SizedBox(height: 8),
        Text(
          'Stage $stageNumber of $totalStages  ·  $stageName',
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: 20),
        _ProgressBar(progress: progress),
        const SizedBox(height: 8),
        Text(
          '$completedStages of $totalStages stages complete',
          style: AppTypography.caption,
        ),
        const SizedBox(height: AppSpacing.xl),
        GestureDetector(
          onTap: onPractice,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Start Practice',
                style: AppTypography.buttonPrimary.copyWith(
                  color: const Color(0xFF0D1220),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: GestureDetector(
            onTap: onViewPath,
            child: Text(
              'View progression path →',
              style: AppTypography.labelMedium.copyWith(color: AppColors.textTertiary),
            ),
          ),
        ),
      ],
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
              color: AppColors.card,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              height: 2,
              width: constraints.maxWidth * progress.clamp(0.0, 1.0),
              color: AppColors.accent,
            ),
          ],
        );
      },
    );
  }
}

class _StatsStrip extends StatelessWidget {
  const _StatsStrip({
    required this.sessions,
    required this.streak,
    this.bestHold,
  });

  final int sessions;
  final int streak;
  final int? bestHold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(value: '$sessions', label: 'Sessions'),
        _Dot(),
        _StatItem(value: '${streak}d', label: 'Streak'),
        _Dot(),
        _StatItem(
          value: bestHold != null ? '${bestHold}s' : '—',
          label: 'Best hold',
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTypography.headingLarge),
        const SizedBox(height: 2),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          color: AppColors.textTertiary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
