import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/drill_card.dart';
import '../../../domain/entities/progression_stage.dart';
import '../../providers/progress_provider.dart';
import '../../providers/skill_provider.dart';

class ProgressionScreen extends ConsumerWidget {
  const ProgressionScreen({super.key, required this.skillId});

  final String skillId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillAsync = ref.watch(skillByIdProvider(skillId));
    final progress = ref.watch(progressProvider(skillId)).value;

    return skillAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (skill) {
        if (skill == null) return const Scaffold();
        final stageIds = skill.stages.map((s) => s.id).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(skill.name),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () => context.pop(),
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.lg,
              AppSpacing.screenPadding,
              AppSpacing.xxl,
            ),
            itemCount: skill.stages.length,
            itemBuilder: (_, i) {
              final stage = skill.stages[i];
              final isCompleted = progress?.isStageCompleted(stage.id) ?? false;
              final isUnlocked = progress?.isStageUnlocked(stage.id, stageIds) ?? i == 0;
              final isCurrent = progress?.currentStageId == stage.id;

              return _StageTile(
                stage: stage,
                isCompleted: isCompleted,
                isUnlocked: isUnlocked,
                isCurrent: isCurrent,
                isLast: i == skill.stages.length - 1,
              );
            },
          ),
        );
      },
    );
  }
}

class _StageTile extends StatefulWidget {
  const _StageTile({
    required this.stage,
    required this.isCompleted,
    required this.isUnlocked,
    required this.isCurrent,
    required this.isLast,
  });

  final ProgressionStage stage;
  final bool isCompleted;
  final bool isUnlocked;
  final bool isCurrent;
  final bool isLast;

  @override
  State<_StageTile> createState() => _StageTileState();
}

class _StageTileState extends State<_StageTile> {
  bool _expanded = false;

  Color get _numberColor {
    if (widget.isCompleted) return AppColors.success;
    if (widget.isCurrent) return AppColors.accent;
    if (widget.isUnlocked) return AppColors.textSecondary;
    return AppColors.stageLockedText;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stage number column
          Column(
            children: [
              SizedBox(
                width: 36,
                child: Text(
                  widget.stage.order.toString().padLeft(2, '0'),
                  style: AppTypography.headingMedium.copyWith(
                    color: _numberColor,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              if (!widget.isLast)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      width: 1,
                      color: widget.isCompleted
                          ? AppColors.success.withOpacity(0.25)
                          : AppColors.surface,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              child: GestureDetector(
                onTap: widget.isUnlocked
                    ? () => setState(() => _expanded = !_expanded)
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.stage.name,
                            style: AppTypography.headingSmall.copyWith(
                              color: widget.isUnlocked
                                  ? AppColors.textPrimary
                                  : AppColors.stageLockedText,
                            ),
                          ),
                        ),
                        if (widget.isCurrent)
                          Text(
                            'CURRENT',
                            style: AppTypography.labelSmall
                                .copyWith(color: AppColors.accent),
                          ),
                        if (widget.isCompleted)
                          const Icon(Icons.check, size: 14, color: AppColors.success),
                        if (!widget.isUnlocked && !widget.isCompleted)
                          const Icon(Icons.lock_outline,
                              size: 13, color: AppColors.stageLockedText),
                        if (widget.isUnlocked && !widget.isCompleted)
                          Icon(
                            _expanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 16,
                            color: AppColors.textTertiary,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.stage.goal,
                      style: AppTypography.bodySmall.copyWith(
                        color: widget.isUnlocked
                            ? AppColors.textSecondary
                            : AppColors.stageLockedText,
                      ),
                    ),
                    if (widget.isUnlocked) ...[
                      const SizedBox(height: AppSpacing.sm),
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: _StageDetails(stage: widget.stage),
                        crossFadeState: _expanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 220),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StageDetails extends StatelessWidget {
  const _StageDetails({required this.stage});

  final ProgressionStage stage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stage.description, style: AppTypography.bodyMedium),
        const SizedBox(height: AppSpacing.md),
        // Success criteria
        Text(
          'PASS WHEN',
          style: AppTypography.labelSmall.copyWith(color: AppColors.success),
        ),
        const SizedBox(height: 6),
        Text(
          stage.successCriteria,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.success,
            height: 1.5,
          ),
        ),
        if (stage.commonMistakes.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            'COMMON MISTAKES',
            style: AppTypography.labelSmall.copyWith(color: AppColors.warning),
          ),
          const SizedBox(height: 8),
          ...stage.commonMistakes.map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('×  ', style: AppTypography.bodySmall.copyWith(color: AppColors.warning)),
                  Expanded(child: Text(m, style: AppTypography.bodySmall)),
                ],
              ),
            ),
          ),
        ],
        if (stage.drills.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            'DRILLS',
            style: AppTypography.labelSmall,
          ),
          const SizedBox(height: 8),
          ...stage.drills.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: DrillCard(drill: d),
            ),
          ),
        ],
      ],
    );
  }
}
