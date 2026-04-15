import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/skill_card.dart';
import '../../../data/seed/handstand_data.dart';
import '../../../domain/entities/skill.dart';
import '../../providers/progress_provider.dart';
import '../../providers/skill_provider.dart';

class SkillsLibraryScreen extends ConsumerStatefulWidget {
  const SkillsLibraryScreen({super.key});

  @override
  ConsumerState<SkillsLibraryScreen> createState() => _SkillsLibraryScreenState();
}

class _SkillsLibraryScreenState extends ConsumerState<SkillsLibraryScreen> {
  String _query = '';
  SkillDifficulty? _filter;

  @override
  Widget build(BuildContext context) {
    final skillsAsync = ref.watch(allSkillsProvider);
    final hsProgress = ref.watch(progressProvider(handstandSkill.id));

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.lg,
                AppSpacing.screenPadding,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Skills', style: AppTypography.displayMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Choose a skill and start your progression.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _SearchBar(onChanged: (v) => setState(() => _query = v)),
                  const SizedBox(height: AppSpacing.sm),
                  _FilterRow(
                    selected: _filter,
                    onSelect: (d) => setState(
                      () => _filter = _filter == d ? null : d,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: skillsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('$e')),
                data: (skills) {
                  final filtered = skills.where((s) {
                    final matchesQuery = _query.isEmpty ||
                        s.name.toLowerCase().contains(_query.toLowerCase()) ||
                        s.tags.any((t) =>
                            t.toLowerCase().contains(_query.toLowerCase()));
                    final matchesFilter =
                        _filter == null || s.difficulty == _filter;
                    return matchesQuery && matchesFilter;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Text('No skills found', style: AppTypography.bodyMedium),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                      vertical: AppSpacing.sm,
                    ),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm + 4),
                    itemBuilder: (_, i) {
                      final skill = filtered[i];
                      final progress = hsProgress.value;
                      final completed =
                          skill.id == handstandSkill.id && progress != null
                              ? progress.completedStageIds.length
                              : 0;
                      final fraction =
                          skill.stages.isNotEmpty && skill.id == handstandSkill.id
                              ? completed / skill.stages.length
                              : 0.0;

                      return SkillCard(
                        skill: skill,
                        progress: fraction,
                        completedStages: completed,
                        onTap: () => context.push('/skills/${skill.id}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      decoration: const InputDecoration(
        hintText: 'Search skills...',
        prefixIcon: Icon(Icons.search, color: AppColors.textTertiary, size: 20),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.selected, required this.onSelect});

  final SkillDifficulty? selected;
  final ValueChanged<SkillDifficulty> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: SkillDifficulty.values.map((d) {
          final isSelected = selected == d;
          final label = d.name[0].toUpperCase() + d.name.substring(1);
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: GestureDetector(
              onTap: () => onSelect(d),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.border,
                  ),
                ),
                child: Text(
                  label,
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
