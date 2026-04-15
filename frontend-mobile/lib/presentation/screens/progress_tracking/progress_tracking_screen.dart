import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/seed/handstand_data.dart';
import '../../providers/progress_provider.dart';
import '../../providers/skill_provider.dart';

class ProgressTrackingScreen extends ConsumerWidget {
  const ProgressTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(progressProvider(handstandSkill.id));
    final sessionsAsync = ref.watch(sessionsProvider(handstandSkill.id));
    final skillAsync = ref.watch(skillByIdProvider(handstandSkill.id));

    return Scaffold(
      body: SafeArea(
        child: progressAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (progress) {
            final totalStages = handstandSkill.stages.length;
            final completed = progress?.completedStageIds.length ?? 0;
            final fraction = totalStages > 0 ? completed / totalStages : 0.0;

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
                        Text('Progress', style: AppTypography.displayMedium),
                        const SizedBox(height: AppSpacing.xxl),
                        _OverviewSection(
                          progress: fraction,
                          completed: completed,
                          total: totalStages,
                          streak: progress?.practiceStreak ?? 0,
                          sessions: progress?.totalSessions ?? 0,
                          bestHold: progress?.bestHoldSeconds,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        SectionHeader(title: 'Stage Breakdown'),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),
                ),
                // Stage breakdown
                skillAsync.when(
                  loading: () =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  error: (_, __) =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  data: (skill) {
                    if (skill == null) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenPadding,
                      ),
                      sliver: SliverList.separated(
                        itemCount: skill.stages.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.sm + 4),
                        itemBuilder: (_, i) {
                          final stage = skill.stages[i];
                          final isCompleted =
                              progress?.isStageCompleted(stage.id) ?? false;
                          final count =
                              progress?.stagePracticeCount[stage.id] ?? 0;
                          return _StageRow(
                            order: stage.order,
                            name: stage.name,
                            isCompleted: isCompleted,
                            sessionCount: count,
                          );
                        },
                      ),
                    );
                  },
                ),
                // Recent sessions
                sessionsAsync.when(
                  loading: () =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  error: (_, __) =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  data: (sessions) {
                    if (sessions.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.screenPadding,
                            AppSpacing.xxl,
                            AppSpacing.screenPadding,
                            0,
                          ),
                          child: Text(
                            'No sessions yet. Complete your first practice.',
                            style: AppTypography.bodyMedium,
                          ),
                        ),
                      );
                    }

                    final recent = sessions.reversed.take(10).toList();
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.screenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSpacing.sectionGap),
                            SectionHeader(title: 'Recent Sessions'),
                            const SizedBox(height: AppSpacing.md),
                            ...recent.map(
                              (s) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.md,
                                ),
                                child: _SessionRow(session: s),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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

class _OverviewSection extends StatelessWidget {
  const _OverviewSection({
    required this.progress,
    required this.completed,
    required this.total,
    required this.streak,
    required this.sessions,
    this.bestHold,
  });

  final double progress;
  final int completed;
  final int total;
  final int streak;
  final int sessions;
  final int? bestHold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HANDSTAND',
          style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${(progress * 100).round()}%',
              style: AppTypography.displayLarge.copyWith(color: AppColors.accent),
            ),
            const SizedBox(width: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '$completed of $total stages',
                style: AppTypography.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        // Progress bar
        LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Container(height: 2, width: constraints.maxWidth, color: AppColors.card),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                height: 2,
                width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                color: AppColors.accent,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            _MiniStat(value: '$sessions', label: 'Sessions'),
            const SizedBox(width: AppSpacing.xl),
            _MiniStat(value: '${streak}d', label: 'Streak'),
            if (bestHold != null) ...[
              const SizedBox(width: AppSpacing.xl),
              _MiniStat(value: '${bestHold}s', label: 'Best hold'),
            ],
          ],
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.value, required this.label});

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

class _StageRow extends StatelessWidget {
  const _StageRow({
    required this.order,
    required this.name,
    required this.isCompleted,
    required this.sessionCount,
  });

  final int order;
  final String name;
  final bool isCompleted;
  final int sessionCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            order.toString().padLeft(2, '0'),
            style: AppTypography.headingMedium.copyWith(
              color: isCompleted ? AppColors.success : AppColors.textTertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              name,
              style: AppTypography.headingSmall.copyWith(
                color: isCompleted ? AppColors.success : AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            sessionCount > 0 ? '$sessionCount sessions' : '—',
            style: AppTypography.caption.copyWith(
              color: isCompleted ? AppColors.success : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.session});

  final dynamic session;

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${d.day}/${d.month}/${d.year}';
  }

  String _formatDuration(int s) {
    final m = s ~/ 60;
    final rem = s % 60;
    return m > 0 ? '${m}m ${rem}s' : '${rem}s';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_formatDate(session.date), style: AppTypography.headingSmall),
              Text(
                _formatDuration(session.durationSeconds),
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
        if (session.bestHoldSeconds != null)
          Text(
            '${session.bestHoldSeconds}s hold',
            style: AppTypography.caption.copyWith(color: AppColors.accent),
          ),
      ],
    );
  }
}
