import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  final _pages = const [_PageOne(), _PageTwo(), _PageThree()];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) context.go('/home');
  }

  void _next() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, AppSpacing.md, AppSpacing.md, 0),
                child: GestureDetector(
                  onTap: _finish,
                  child: Text(
                    'Skip',
                    style: AppTypography.labelMedium
                        .copyWith(color: AppColors.textTertiary),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: _pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.md,
                AppSpacing.screenPadding,
                AppSpacing.xl,
              ),
              child: Column(
                children: [
                  _PageDots(count: _pages.length, current: _page),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    label: _page == _pages.length - 1 ? 'Begin Training' : 'Continue',
                    onTap: _next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: i == current ? 20 : 5,
          height: 5,
          decoration: BoxDecoration(
            color: i == current ? AppColors.accent : AppColors.textTertiary,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _PageOne extends StatelessWidget {
  const _PageOne();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '01',
            style: AppTypography.displayHero.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Master\nYour Body',
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Learn calisthenics skills step by step — clear progressions, '
            'guided drills, and real troubleshooting for when things get hard.',
            style: AppTypography.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _PageTwo extends StatelessWidget {
  const _PageTwo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '02',
            style: AppTypography.displayHero.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Clear\nProgressions',
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Every skill is broken into stages with prerequisites, success criteria, '
            'and corrective exercises when you hit a wall.',
            style: AppTypography.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.xl),
          _FeatureItem('Unlock stages as you progress'),
          const SizedBox(height: AppSpacing.md),
          _FeatureItem('Get fixes for common hurdles'),
          const SizedBox(height: AppSpacing.md),
          _FeatureItem('Track every session offline'),
        ],
      ),
    );
  }
}

class _PageThree extends StatelessWidget {
  const _PageThree();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '03',
            style: AppTypography.displayHero.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Start with\nHandstands',
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Your first goal: a freestanding handstand. 8 stages, from wrist conditioning '
            'to 10-second holds. Every session moves you forward.',
            style: AppTypography.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '→',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.accent),
        ),
        const SizedBox(width: AppSpacing.sm + 4),
        Expanded(
          child: Text(text, style: AppTypography.bodyMedium),
        ),
      ],
    );
  }
}
