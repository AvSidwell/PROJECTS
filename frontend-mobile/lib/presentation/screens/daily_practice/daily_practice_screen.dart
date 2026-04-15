import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/drill_card.dart';
import '../../../domain/entities/practice_session.dart';
import '../../providers/practice_session_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/skill_provider.dart';

class DailyPracticeScreen extends ConsumerStatefulWidget {
  const DailyPracticeScreen({super.key, required this.skillId});

  final String skillId;

  @override
  ConsumerState<DailyPracticeScreen> createState() => _DailyPracticeScreenState();
}

class _DailyPracticeScreenState extends ConsumerState<DailyPracticeScreen> {
  Timer? _ticker;
  bool _sessionComplete = false;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      ref.read(practiceSessionProvider.notifier).tick();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _finishSession(
    String stageId,
    Set<String> completedDrillIds,
    int elapsedSeconds,
    int? bestHold,
  ) async {
    final session = PracticeSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      skillId: widget.skillId,
      stageId: stageId,
      date: DateTime.now(),
      durationSeconds: elapsedSeconds,
      completedDrillIds: completedDrillIds.toList(),
      completed: true,
      bestHoldSeconds: bestHold,
    );

    await ref
        .read(progressProvider(widget.skillId).notifier)
        .completeSession(session);

    setState(() => _sessionComplete = true);
  }

  @override
  Widget build(BuildContext context) {
    final skillAsync = ref.watch(skillByIdProvider(widget.skillId));
    final progress = ref.watch(progressProvider(widget.skillId)).value;
    final sessionState = ref.watch(practiceSessionProvider);

    return skillAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (skill) {
        if (skill == null) return const Scaffold();

        final currentStageId =
            progress?.currentStageId ?? skill.stages.first.id;
        final currentStage = skill.stages.firstWhere(
          (s) => s.id == currentStageId,
          orElse: () => skill.stages.first,
        );

        if (_sessionComplete) {
          return _CompletionView(
            stageName: currentStage.name,
            elapsed: sessionState.elapsedSeconds,
            bestHold: sessionState.bestHoldSeconds,
            onDone: () {
              ref.read(practiceSessionProvider.notifier).reset();
              context.pop();
            },
          );
        }

        final allChecked = currentStage.drills.isNotEmpty &&
            currentStage.drills.every(
              (d) => sessionState.checkedDrillIds.contains(d.id),
            );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Practice'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () => context.pop(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: _ElapsedTimer(seconds: sessionState.elapsedSeconds),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.screenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _StageHeader(stage: currentStage),
                            const SizedBox(height: AppSpacing.sectionGap),
                            Text(
                              'DRILLS',
                              style: AppTypography.labelSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tap each drill to see instructions. Check it off when done.',
                              style: AppTypography.bodySmall,
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
                        itemCount: currentStage.drills.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (_, i) {
                          final drill = currentStage.drills[i];
                          return DrillCard(
                            drill: drill,
                            showCheckbox: true,
                            isChecked: sessionState.checkedDrillIds
                                .contains(drill.id),
                            onChecked: (_) => ref
                                .read(practiceSessionProvider.notifier)
                                .toggleDrill(drill.id),
                          );
                        },
                      ),
                    ),
                    if (currentStage.holdDurationSeconds != null) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.screenPadding),
                          child: _HoldTimer(
                            targetSeconds: currentStage.holdDurationSeconds!,
                            onRecord: (s) => ref
                                .read(practiceSessionProvider.notifier)
                                .recordHold(s),
                          ),
                        ),
                      ),
                    ],
                    const SliverToBoxAdapter(child: SizedBox(height: 120)),
                  ],
                ),
              ),
              _BottomBar(
                allChecked: allChecked,
                onComplete: () => _finishSession(
                  currentStageId,
                  sessionState.checkedDrillIds,
                  sessionState.elapsedSeconds,
                  sessionState.bestHoldSeconds,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StageHeader extends StatelessWidget {
  const _StageHeader({required this.stage});

  final dynamic stage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STAGE ${stage.order}',
          style: AppTypography.labelSmall.copyWith(color: AppColors.accent),
        ),
        const SizedBox(height: 8),
        Text(stage.name, style: AppTypography.displayMedium),
        const SizedBox(height: 6),
        Text(stage.goal, style: AppTypography.bodyMedium),
      ],
    );
  }
}

class _ElapsedTimer extends StatelessWidget {
  const _ElapsedTimer({required this.seconds});

  final int seconds;

  String get _formatted {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatted,
      style: AppTypography.labelMedium.copyWith(
        color: AppColors.accent,
        fontFeatures: [const FontFeature.tabularFigures()],
      ),
    );
  }
}

class _HoldTimer extends StatefulWidget {
  const _HoldTimer({required this.targetSeconds, required this.onRecord});

  final int targetSeconds;
  final ValueChanged<int> onRecord;

  @override
  State<_HoldTimer> createState() => _HoldTimerState();
}

class _HoldTimerState extends State<_HoldTimer> {
  Timer? _timer;
  int _elapsed = 0;
  bool _running = false;
  int? _best;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (_running) {
      _timer?.cancel();
      if (_elapsed > 0) {
        final prev = _best;
        setState(
            () => _best = prev == null ? _elapsed : (_elapsed > prev ? _elapsed : prev));
        widget.onRecord(_elapsed);
      }
      setState(() {
        _running = false;
        _elapsed = 0;
      });
    } else {
      setState(() => _running = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _elapsed++);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (_elapsed / widget.targetSeconds).clamp(0.0, 1.0).toDouble();
    final done = progress >= 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'HOLD TIMER',
              style: AppTypography.labelSmall,
            ),
            if (_best != null)
              Text(
                'Best: ${_best}s',
                style: AppTypography.caption
                    .copyWith(color: AppColors.success),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Progress bar
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) => Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      color: done ? AppColors.success : AppColors.accentSubtle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              _running
                  ? '${_elapsed}s / ${widget.targetSeconds}s'
                  : 'Target: ${widget.targetSeconds}s',
              style: AppTypography.headingSmall.copyWith(
                color: done ? AppColors.success : AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: _toggle,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: _running ? AppColors.card : AppColors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _running ? 'Stop' : 'Start Hold',
                style: AppTypography.buttonPrimary.copyWith(
                  color: _running ? AppColors.warning : const Color(0xFF0D1220),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.allChecked, required this.onComplete});

  final bool allChecked;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.md,
        AppSpacing.screenPadding,
        AppSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      color: AppColors.surface,
      child: AppButton(
        label: allChecked ? 'Complete Session' : 'Complete Session',
        onTap: onComplete,
        icon: Icons.check,
      ),
    );
  }
}

class _CompletionView extends StatelessWidget {
  const _CompletionView({
    required this.stageName,
    required this.elapsed,
    required this.onDone,
    this.bestHold,
  });

  final String stageName;
  final int elapsed;
  final VoidCallback onDone;
  final int? bestHold;

  String get _elapsedFormatted {
    final m = elapsed ~/ 60;
    final s = elapsed % 60;
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '✓',
                style: AppTypography.displayHero.copyWith(color: AppColors.accent),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Session\nComplete', style: AppTypography.displayLarge),
              const SizedBox(height: AppSpacing.md),
              Text(stageName, style: AppTypography.bodyLarge),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                children: [
                  _StatItem(label: 'Duration', value: _elapsedFormatted),
                  if (bestHold != null) ...[
                    const SizedBox(width: AppSpacing.xl),
                    _StatItem(label: 'Best Hold', value: '${bestHold}s'),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppButton(label: 'Done', onTap: onDone),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTypography.displayMedium),
        const SizedBox(height: 2),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
