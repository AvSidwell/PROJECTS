import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/drill_card.dart';
import '../../../domain/entities/hurdle.dart';
import '../../providers/skill_provider.dart';

class HurdlesScreen extends ConsumerWidget {
  const HurdlesScreen({super.key, required this.skillId});

  final String skillId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillAsync = ref.watch(skillByIdProvider(skillId));

    return skillAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (skill) {
        if (skill == null) return const Scaffold();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Hurdles & Fixes'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () => context.pop(),
            ),
          ),
          body: skill.hurdles.isEmpty
              ? Center(
                  child: Text(
                    'No hurdles documented yet.',
                    style: AppTypography.bodyMedium,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.screenPadding),
                  itemCount: skill.hurdles.length + 1,
                  itemBuilder: (_, i) {
                    if (i == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Troubleshooting',
                              style: AppTypography.displayMedium,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Stuck on something? Find the cause and the fix.',
                              style: AppTypography.bodyMedium,
                            ),
                          ],
                        ),
                      );
                    }
                    final hurdle = skill.hurdles[i - 1];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                      child: _HurdleItem(hurdle: hurdle),
                    );
                  },
                ),
        );
      },
    );
  }
}

class _HurdleItem extends StatefulWidget {
  const _HurdleItem({required this.hurdle});

  final Hurdle hurdle;

  @override
  State<_HurdleItem> createState() => _HurdleItemState();
}

class _HurdleItemState extends State<_HurdleItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          behavior: HitTestBehavior.opaque,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.hurdle.title,
                  style: AppTypography.headingMedium.copyWith(
                    color: _expanded ? AppColors.warning : AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: AppColors.textTertiary,
                size: 20,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: _HurdleDetails(hurdle: widget.hurdle),
          crossFadeState:
              _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
        ),
      ],
    );
  }
}

class _HurdleDetails extends StatelessWidget {
  const _HurdleDetails({required this.hurdle});

  final Hurdle hurdle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hurdle.description, style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          _SubSection(
            title: 'WHY THIS HAPPENS',
            color: AppColors.warning,
            items: hurdle.causes,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SubSection(
            title: 'HOW TO FIX IT',
            color: AppColors.success,
            items: hurdle.fixes,
          ),
          if (hurdle.correctiveExercises.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              'CORRECTIVE EXERCISES',
              style: AppTypography.labelSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            ...hurdle.correctiveExercises.map(
              (d) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: DrillCard(drill: d),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SubSection extends StatelessWidget {
  const _SubSection({
    required this.title,
    required this.color,
    required this.items,
  });

  final String title;
  final Color color;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.labelSmall.copyWith(color: color)),
        const SizedBox(height: 10),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '— ',
                  style: AppTypography.bodySmall.copyWith(color: color),
                ),
                Expanded(child: Text(item, style: AppTypography.bodyMedium)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
