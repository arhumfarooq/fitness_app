import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/data/repositories/exports.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<double> _weeklyData = [
    65.0,
    78.0,
    82.0,
    71.0,
    88.0,
    75.0,
    90.0,
  ];
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const int _stepGoal = 10000;

  late int _steps;
  bool _isTrackingSteps = true;
  Timer? _stepsTimer;

  @override
  void initState() {
    super.initState();
    _steps = 8432;
    _syncStepsTimer();
  }

  @override
  void dispose() {
    _stepsTimer?.cancel();
    super.dispose();
  }

  void _toggleStepsTracking() {
    setState(() {
      _isTrackingSteps = !_isTrackingSteps;
    });
    _syncStepsTimer();
  }

  void _syncStepsTimer() {
    _stepsTimer?.cancel();
    if (!_isTrackingSteps) return;

    _stepsTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _steps >= _stepGoal) return;
      setState(() {
        _steps = math.min(_steps + 3, _stepGoal);
      });
    });
  }

  String get _formattedSteps {
    final text = _steps.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) buffer.write(',');
      buffer.write(text[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final workout = WorkoutRepository.getHomeWorkouts().first;
    final stepsProgress = _steps / _stepGoal;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                AppSizes.space3,
                AppSizes.screenPadding,
                AppSizes.space3,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomePrefix,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Alex',
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Mon, Aug 10',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Semantics(
                        button: true,
                        label: 'Show streak status',
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.space3,
                            vertical: AppSizes.space2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.activityContainer,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusPill,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColors.brandPrimary,
                                size: AppSizes.iconMd,
                              ),
                              const SizedBox(width: AppSizes.space1),
                              Text(
                                '12 days',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      IconActionButton(
                        icon: Icons.notifications_rounded,
                        tooltip: 'Notifications',
                        semanticLabel: 'Open notifications',
                        onPressed: () => context.push(AppRoutes.notifications),
                      ),
                      // const SizedBox(width: AppSizes.space1),
                      // IconActionButton(
                      //   icon: Icons.person_rounded,
                      //   tooltip: 'Profile',
                      //   semanticLabel: 'Open profile',
                      //   onPressed: () => context.push(AppRoutes.profile),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.screenPadding,
                  AppSizes.space2,
                  AppSizes.screenPadding,
                  100,
                ),
                children: [
                  LargeMetricCard(
                    title: 'TODAY\'S PROGRESS',
                    value: _formattedSteps,
                    subtitle: 'steps',
                    detail: '${(stepsProgress * 100).round()}% of daily goal',
                    progress: stepsProgress,
                    accentColor: AppColors.brandPrimary,
                    trailing: _ProgressRunner(
                      isActive: _isTrackingSteps,
                      size: 38,
                      figureSize: 30,
                    ),
                    valueTrailing: _StepTrackingButton(
                      isTracking: _isTrackingSteps,
                      onPressed: _toggleStepsTracking,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final useStackedLayout =
                            constraints.maxWidth < 310 ||
                            MediaQuery.textScalerOf(context).scale(1) > 1.3;
                        final supportMetrics = Row(
                          children: [
                            Expanded(
                              child: _MetricPair(
                                label: 'Calories',
                                value: '612',
                                color: AppColors.energyOrange,
                              ),
                            ),
                            const SizedBox(width: AppSizes.space2),
                            Expanded(
                              child: _MetricPair(
                                label: 'Active',
                                value: '42m',
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        );
                        final progressLine = _StepProgressLine(
                          progress: stepsProgress,
                        );

                        if (useStackedLayout) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              progressLine,
                              const SizedBox(height: AppSizes.space3),
                              const _ProgressSummary(),
                              const SizedBox(height: AppSizes.space3),
                              supportMetrics,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  progressLine,
                                  const SizedBox(height: AppSizes.space3),
                                  const _ProgressSummary(),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSizes.space3),
                            SizedBox(width: 184, child: supportMetrics),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSizes.space4),
                  Text(
                    "TODAY'S WORKOUT",
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.space2),
                  WorkoutHeroCard(
                    title: workout.name,
                    subtitle: '${workout.duration} - ${workout.difficulty}',
                    duration: workout.duration,
                    difficulty: workout.difficulty,
                    imageUrl: workout.imageUrl,
                    ctaLabel: AppStrings.startBtn,
                    onPressed: () {
                      ToastHelper.success(
                        context,
                        AppStrings.workoutStarted,
                        description: AppStrings.workoutStartedSub,
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.space4),
                  Text(
                    'QUICK ACTIONS',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.space2),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.restaurant_rounded,
                          label: 'Meals',
                          color: AppColors.workoutCalories,
                          onTap: () => context.push(AppRoutes.meals),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.play_circle_outline_rounded,
                          label: 'AI Videos',
                          color: AppColors.brandPrimary,
                          onTap: () => context.push(AppRoutes.aiVideos),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.water_drop_outlined,
                          label: 'Water',
                          color: AppColors.hydrationBlue,
                          onTap: () => context.push(AppRoutes.water),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.emoji_events_outlined,
                          label: 'Challenges',
                          color: AppColors.activityOrange,
                          onTap: () => context.push(AppRoutes.challenges),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.space4),
                  ChartCard(
                    title: 'WEEKLY ACTIVITY',
                    value: '7.8k avg steps',
                    caption: 'Steady trend across the week',
                    data: _weeklyData,
                    labels: _days,
                    accentColor: AppColors.brandPrimary,
                  ),
                  const SizedBox(height: AppSizes.space4),
                  Text(
                    'HEALTH & RECOVERY',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.space2),
                  Column(
                    children: [
                      CompactMetricTile(
                        label: 'Hydration',
                        value: '6/8',
                        detail: 'glasses today',
                        icon: Icons.water_drop_rounded,
                        iconColor: AppColors.hydrationBlue,
                        backgroundColor: AppColors.hydrationContainer,
                      ),
                      const SizedBox(height: AppSizes.space3),
                      CompactMetricTile(
                        label: 'Recovery',
                        value: '87%',
                        detail: 'ready to train',
                        icon: Icons.favorite_rounded,
                        iconColor: AppColors.aiPurple,
                        backgroundColor: AppColors.aiContainer,
                      ),
                      const SizedBox(height: AppSizes.space3),
                      CompactMetricTile(
                        label: 'Calories',
                        value: '612',
                        detail: 'burned today',
                        icon: Icons.local_fire_department_rounded,
                        iconColor: AppColors.energyOrange,
                        backgroundColor: AppColors.energyContainer,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const MobileNavBar(),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
    child: AppCard(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.space3,
        horizontal: AppSizes.space2,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

class _ProgressSummary extends StatelessWidget {
  const _ProgressSummary();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Steady pace toward today\'s goal.',
      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
    );
  }
}

class _StepProgressLine extends StatelessWidget {
  final double progress;

  const _StepProgressLine({required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusPill),
      child: LinearProgressIndicator(
        value: progress.clamp(0.0, 1.0),
        minHeight: 7,
        backgroundColor: AppColors.surface3,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandPrimary),
      ),
    );
  }
}

class _StepTrackingButton extends StatelessWidget {
  final bool isTracking;
  final VoidCallback onPressed;

  const _StepTrackingButton({
    required this.isTracking,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isTracking ? 'Pause steps' : 'Continue steps',
      child: IconButton.filled(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.activityContainer,
          foregroundColor: AppColors.brandPrimary,
          minimumSize: const Size(
            AppSizes.minTouchTarget,
            AppSizes.minTouchTarget,
          ),
        ),
        icon: Icon(isTracking ? Icons.pause_rounded : Icons.play_arrow_rounded),
      ),
    );
  }
}

class _ProgressRunner extends StatefulWidget {
  final bool isActive;
  final double size;
  final double figureSize;

  const _ProgressRunner({
    required this.isActive,
    this.size = 44,
    this.figureSize = 44,
  });

  @override
  State<_ProgressRunner> createState() => _ProgressRunnerState();
}

class _ProgressRunnerState extends State<_ProgressRunner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _step;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 980),
    );
    if (widget.isActive) _controller.repeat();
    _step = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void didUpdateWidget(covariant _ProgressRunner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive == oldWidget.isActive) return;
    if (widget.isActive) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(
        color: AppColors.activityContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SizedBox.square(
          dimension: widget.figureSize,
          child: _WalkingFigure(
            animation: _step,
            color: AppColors.brandPrimary,
          ),
        ),
      ),
    );
  }
}

class _WalkingFigure extends StatelessWidget {
  final Animation<double> animation;
  final Color color;

  const _WalkingFigure({required this.animation, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _WalkingFigurePainter(phase: animation.value, color: color),
        );
      },
    );
  }
}

class _WalkingFigurePainter extends CustomPainter {
  final double phase;
  final Color color;

  const _WalkingFigurePainter({required this.phase, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerX = size.width * 0.5;
    final cycle = phase * math.pi * 2;
    final stride = math.sin(cycle);
    final counterStride = math.sin(cycle + math.pi);
    final bob = -1.2 * stride.abs();
    const lean = 1.4;
    final hip = Offset(centerX + lean * 0.35, size.height * 0.57 + bob);
    final shoulder = Offset(centerX + lean, size.height * 0.36 + bob);
    final head = Offset(centerX + lean + 1, size.height * 0.22 + bob);

    canvas.drawCircle(head, 3.8, fillPaint);
    canvas.drawLine(shoulder, hip, paint);

    final leftElbow = Offset(
      shoulder.dx - 5 - counterStride * 2,
      size.height * 0.46 + bob - counterStride * 1.4,
    );
    final rightElbow = Offset(
      shoulder.dx + 5 + stride * 2,
      size.height * 0.46 + bob - stride * 1.4,
    );
    final leftHand = Offset(
      shoulder.dx - 9 - counterStride * 3.5,
      size.height * 0.54 + bob + counterStride * 3,
    );
    final rightHand = Offset(
      shoulder.dx + 9 + stride * 3.5,
      size.height * 0.54 + bob + stride * 3,
    );
    canvas.drawLine(shoulder, leftElbow, paint);
    canvas.drawLine(leftElbow, leftHand, paint);
    canvas.drawLine(shoulder, rightElbow, paint);
    canvas.drawLine(rightElbow, rightHand, paint);

    final leftKnee = Offset(
      hip.dx - 4 - stride * 2.8,
      size.height * 0.70 + bob - stride.abs() * 1.2,
    );
    final rightKnee = Offset(
      hip.dx + 4 - counterStride * 2.8,
      size.height * 0.70 + bob - counterStride.abs() * 1.2,
    );
    final leftFoot = Offset(
      hip.dx - 8 - stride * 3.8,
      size.height * 0.82 - math.max(stride, 0) * 1.5,
    );
    final rightFoot = Offset(
      hip.dx + 8 - counterStride * 3.8,
      size.height * 0.82 - math.max(counterStride, 0) * 1.5,
    );

    canvas.drawLine(hip, leftKnee, paint);
    canvas.drawLine(leftKnee, leftFoot, paint);
    canvas.drawLine(hip, rightKnee, paint);
    canvas.drawLine(rightKnee, rightFoot, paint);
  }

  @override
  bool shouldRepaint(covariant _WalkingFigurePainter oldDelegate) {
    return oldDelegate.phase != phase || oldDelegate.color != color;
  }
}

class _MetricPair extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricPair({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space3),
      decoration: BoxDecoration(
        color: AppColors.surface3,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.space1),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: AppTextStyles.title.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
