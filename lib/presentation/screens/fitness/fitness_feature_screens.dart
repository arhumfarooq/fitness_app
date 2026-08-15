import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _page = PageController();
  int _index = 0;
  final _slides = const [
    (
      'AI Powered Personalization',
      'Get workouts, meals and insights tailored just for you.',
      Icons.auto_awesome_rounded,
    ),
    (
      'Track. Improve. Transform.',
      'Track your progress and achieve your goals.',
      Icons.show_chart_rounded,
    ),
  ];

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  void _next() {
    if (_index == _slides.length - 1) {
      context.go(AppRoutes.login);
    } else {
      _page.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _page,
                  itemCount: _slides.length,
                  onPageChanged: (value) => setState(() => _index = value),
                  itemBuilder: (_, i) =>
                      _OnboardingSlide(index: i, data: _slides[i]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _index ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: i == _index
                          ? AppColors.brandPrimary
                          : AppColors.borderStrong,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.space5),
              AppButton(
                label: _index == _slides.length - 1 ? 'Get Started' : 'Next',
                onPressed: _next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  final int index;
  final (String, String, IconData) data;
  const _OnboardingSlide({required this.index, required this.data});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: AppSizes.space4),
      Text(data.$1, style: AppTextStyles.headingLarge),
      const SizedBox(height: AppSizes.space3),
      Text(
        data.$2,
        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
      ),
      const SizedBox(height: AppSizes.space5),
      Expanded(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface1,
            borderRadius: BorderRadius.circular(AppSizes.radiusExtraLarge),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: index == 0
              ? const _PersonalizationVisual()
              : const _WeightProgressVisual(),
        ),
      ),
    ],
  );
}

class _PersonalizationVisual extends StatelessWidget {
  const _PersonalizationVisual();
  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Positioned(
        top: 30,
        left: 24,
        child: _MiniInsight(
          icon: Icons.show_chart_rounded,
          color: AppColors.hydrationBlue,
        ),
      ),
      Positioned(
        top: 84,
        right: 20,
        child: _MiniInsight(
          icon: Icons.auto_awesome_rounded,
          color: AppColors.activityOrange,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.space4),
        child: Image.network(
          'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=600',
          width: 230,
          height: 265,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.fitness_center_rounded,
            size: 120,
            color: AppColors.brandPrimary,
          ),
        ),
      ),
    ],
  );
}

class _MiniInsight extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _MiniInsight({required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSizes.space3),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 12)],
    ),
    child: Icon(icon, color: color, size: 30),
  );
}

class _WeightProgressVisual extends StatelessWidget {
  const _WeightProgressVisual();
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(AppSizes.radiusExtraLarge),
    child: Image.asset(
      'assets/images/onboarding_weight_progress.png',
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
      semanticLabel: 'Weight progress chart showing 80 percent of goal',
    ),
  );
}

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});
  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _age = TextEditingController(text: '22');
  final _height = TextEditingController(text: '178');
  final _weight = TextEditingController(text: '72');
  String _gender = 'Male';
  @override
  void dispose() {
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _FormShell(
    title: 'Tell Us About You',
    subtitle: 'This helps us personalize your experience',
    children: [
      _field('Age', _age, TextInputType.number),
      _select('Gender', _gender, [
        'Male',
        'Female',
        'Prefer not to say',
      ], (v) => setState(() => _gender = v)),
      _field('Height (cm)', _height, TextInputType.number),
      _field('Current Weight (kg)', _weight, TextInputType.number),
      AppButton(label: 'Next', onPressed: () => context.go(AppRoutes.goals)),
    ],
  );
}

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});
  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  int selected = 2;
  final options = const [
    (
      'Lose Weight',
      'Burn fat and get lean',
      Icons.local_fire_department_outlined,
    ),
    ('Maintain Weight', 'Stay fit and healthy', Icons.balance_outlined),
    ('Gain Muscle', 'Build strength and size', Icons.fitness_center_outlined),
    ('Improve Fitness', 'Overall fitness & energy', Icons.bolt_outlined),
  ];
  @override
  Widget build(BuildContext context) => _FormShell(
    title: "What's Your Goal?",
    subtitle: 'Choose your primary goal',
    children: [
      ...List.generate(options.length, (i) {
        final item = options[i];
        final active = selected == i;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.space3),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            onTap: () => setState(() => selected = i),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.cardPadding),
              decoration: BoxDecoration(
                color: active ? AppColors.surface1 : AppColors.background,
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                border: Border.all(
                  color: active
                      ? AppColors.brandPrimary
                      : AppColors.borderSubtle,
                  width: active ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(item.$3, color: AppColors.brandPrimary),
                  const SizedBox(width: AppSizes.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.$1, style: AppTextStyles.label),
                        Text(
                          item.$2,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (active)
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.brandPrimary,
                    ),
                ],
              ),
            ),
          ),
        );
      }),
      AppButton(label: 'Next', onPressed: () => context.go(AppRoutes.home)),
    ],
  );
}

class _FormShell extends StatelessWidget {
  final String title, subtitle;
  final List<Widget> children;
  const _FormShell({
    required this.title,
    required this.subtitle,
    required this.children,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.space5),
              Text(title, style: AppTextStyles.headingLarge),
              const SizedBox(height: AppSizes.space2),
              Text(
                subtitle,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSizes.space6),
              ...children.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.space4),
                  child: e,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _field(
  String label,
  TextEditingController controller,
  TextInputType type,
) => AppTextField(
  label: label,
  hint: 'Enter $label',
  controller: controller,
  keyboardType: type,
);
Widget _select(
  String label,
  String value,
  List<String> values,
  ValueChanged<String> onChanged,
) => DropdownButtonFormField<String>(
  initialValue: value,
  decoration: InputDecoration(labelText: label),
  items: values.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
  onChanged: (v) {
    if (v != null) onChanged(v);
  },
);

class StepsScreen extends StatelessWidget {
  const StepsScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'Steps & Activity',
    children: [
      _CircleMetric(
        value: '8,432',
        label: 'Steps',
        progress: .84,
        color: AppColors.fitnessPositive,
      ),
      _statGrid([
        ('Distance', '8.4 km', AppColors.hydrationBlue),
        ('Calories', '320 kcal', AppColors.workoutCalories),
        ('Active time', '1h 25m', AppColors.activityOrange),
      ]),
      const _ChartPlaceholder(title: 'Hourly Activity'),
      SectionHeader(title: 'Activity History'),
      const _ListTile(
        title: 'Morning Walk',
        subtitle: '7:30 AM · 4.2 km · 210 kcal',
        icon: Icons.directions_walk_rounded,
      ),
      const _ListTile(
        title: 'Evening Workout',
        subtitle: '6:15 PM · 3.2 km · 110 kcal',
        icon: Icons.fitness_center_rounded,
      ),
    ],
  );
}

class AiVideosScreen extends StatelessWidget {
  const AiVideosScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'AI Fitness Videos',
    children: [
      TextField(
        decoration: const InputDecoration(
          hintText: 'Search videos',
          prefixIcon: Icon(Icons.search_rounded),
        ),
      ),
      const SizedBox(height: AppSizes.space3),
      Wrap(
        spacing: 8,
        children: [
          'All',
          'Beginner',
          'Form Tips',
          'Strength',
          'Cardio',
          'Mobility',
        ].map((x) => Chip(label: Text(x))).toList(),
      ),
      ...[
        'How to Squat',
        'Push Ups',
        'Plank Hold',
        'Deadlift Basics',
        'Meal Prep Tips',
      ].map((x) => _VideoCard(title: x)),
    ],
  );
}

class CalorieScannerScreen extends StatelessWidget {
  const CalorieScannerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: 300,
                  height: 380,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  ),
                  child: const Center(
                    child: Text(
                      'Point your camera at your meal',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.space5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.flash_off, color: Colors.white),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    onPressed: () => context.push(AppRoutes.scanResult),
                    child: const Icon(Icons.camera_alt),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white,
                    ),
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

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'Nutrition Result',
    children: [
      Container(
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.surface3,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: const Center(child: Icon(Icons.restaurant_rounded, size: 64)),
      ),
      const SizedBox(height: AppSizes.space4),
      Text(
        'Caesar Salad with Cherry Tomatoes',
        style: AppTextStyles.headingMedium,
      ),
      Text(
        'Estimated nutrition',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
      ),
      _statGrid([
        ('Calories', '330', AppColors.workoutCalories),
        ('Protein', '8g', AppColors.workoutCalories),
        ('Carbs', '20g', AppColors.activityOrange),
        ('Fats', '18g', AppColors.hydrationBlue),
      ]),
      SectionHeader(title: 'Ingredients'),
      const _ListTile(
        title: 'Lettuce · Cherry Tomatoes',
        subtitle: 'Croutons · Parmesan Cheese',
        icon: Icons.check_circle_outline,
      ),
      AppButton(label: 'Save Meal', onPressed: () => context.pop()),
    ],
  );
}

class CalorieSummaryScreen extends StatelessWidget {
  const CalorieSummaryScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'Calorie Summary',
    children: [
      Wrap(
        spacing: 8,
        children: ['Day', 'Week', 'Month', 'Year']
            .map(
              (x) => ChoiceChip(
                label: Text(x),
                selected: x == 'Day',
                onSelected: (_) {},
              ),
            )
            .toList(),
      ),
      _CircleMetric(
        value: '2861',
        label: '/ 3500 kcal',
        progress: .82,
        color: AppColors.workoutCalories,
      ),
      _statGrid([
        ('Protein', '130 / 160g', AppColors.workoutCalories),
        ('Carbs', '278 / 350g', AppColors.activityOrange),
        ('Fats', '70 / 90g', AppColors.hydrationBlue),
      ]),
      const _ChartPlaceholder(title: 'Calorie Intake Over Time'),
    ],
  );
}

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});
  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  int glasses = 6;
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'Water Tracker',
    children: [
      _CircleMetric(
        value: '$glasses',
        label: 'Glasses',
        progress: glasses / 8,
        color: AppColors.hydrationBlue,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () =>
                setState(() => glasses = (glasses - 1).clamp(0, 8)),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          IconButton(
            onPressed: () =>
                setState(() => glasses = (glasses + 1).clamp(0, 8)),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      Wrap(
        spacing: 12,
        children: List.generate(
          8,
          (i) => Icon(
            Icons.local_drink,
            color: i < glasses
                ? AppColors.hydrationBlue
                : AppColors.borderStrong,
            size: 34,
          ),
        ),
      ),
    ],
  );
}

class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'Sleep Tracker',
    children: [
      _CircleMetric(
        value: '7.2',
        label: 'hours',
        progress: .9,
        color: AppColors.hydrationBlue,
      ),
      const _ChartPlaceholder(title: 'Sleep Timeline'),
      _statGrid([
        ('Deep', '2.1 hrs', AppColors.hydrationBlue),
        ('Light', '4.2 hrs', AppColors.hydrationBlue),
        ('Awake', '0.9 hrs', AppColors.activityOrange),
      ]),
    ],
  );
}

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'Achievements',
    children: [
      Text(
        '12 / 24 Unlocked',
        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
      ),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children:
            [
                  'First Workout',
                  '7 Day Streak',
                  'Hydration Hero',
                  'Early Bird',
                  'Weight Tracker',
                  'Consistency',
                ]
                .map(
                  (x) => AppCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.workspace_premium_rounded,
                          color: AppColors.activityOrange,
                          size: 32,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          x,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
      ),
    ],
  );
}

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'Upper Body Strength',
    children: [
      Text(
        '4 Weeks Plan',
        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
      ),
      ...[
        'Day 1 · Push',
        'Day 2 · Pull',
        'Day 3 · Rest',
        'Day 4 · Upper Mix',
      ].map(
        (x) => _ListTile(
          title: x,
          subtitle: 'Chest · Shoulders · Triceps',
          icon: Icons.chevron_right_rounded,
        ),
      ),
    ],
  );
}

class EditGoalScreen extends StatelessWidget {
  const EditGoalScreen({super.key});
  @override
  Widget build(BuildContext context) => _FormShell(
    title: 'Edit Goal',
    subtitle: 'Keep your plan aligned with your target',
    children: [
      _select('Goal', 'Gain Muscle', [
        'Lose Weight',
        'Maintain Weight',
        'Gain Muscle',
        'Improve Fitness',
      ], (_) {}),
      const TextField(decoration: InputDecoration(labelText: 'Target Weight')),
      const TextField(decoration: InputDecoration(labelText: 'Target Date')),
      _select('Activity Level', 'Moderate', [
        'Low',
        'Moderate',
        'High',
      ], (_) {}),
      AppButton(label: 'Save Changes', onPressed: () => context.pop()),
    ],
  );
}

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});
  @override
  Widget build(BuildContext context) => _FeatureShell(
    title: 'GYMORA Premium',
    children: [
      AppCard(
        child: Column(
          children: [
            const Icon(
              Icons.workspace_premium_rounded,
              size: 54,
              color: AppColors.activityOrange,
            ),
            const SizedBox(height: 12),
            Text('Train without limits', style: AppTextStyles.headingMedium),
            Text(
              'Ad-free experience, premium workouts, advanced plans and enhanced analytics.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      ...[
        'Ad-free experience',
        'Premium workouts',
        'Advanced analytics',
        'Personalized plans',
      ].map(
        (x) => _ListTile(
          title: x,
          subtitle: 'Included with Premium',
          icon: Icons.check_circle,
        ),
      ),
      AppButton(label: 'Upgrade to Premium', onPressed: () {}),
    ],
  );
}

class _FeatureShell extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _FeatureShell({required this.title, required this.children});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.screenPadding),
        children: children
            .map(
              (x) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.space4),
                child: x,
              ),
            )
            .toList(),
      ),
    ),
  );
}

class _CircleMetric extends StatelessWidget {
  final String value, label;
  final double progress;
  final Color color;
  const _CircleMetric({
    required this.value,
    required this.label,
    required this.progress,
    required this.color,
  });
  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 190,
      height: 190,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              value: progress.clamp(0, 1),
              strokeWidth: 12,
              color: color,
              backgroundColor: AppColors.surface3,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: AppTextStyles.displayMetric),
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _statGrid(List<(String, String, Color)> items) => GridView.count(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  crossAxisCount: items.length > 3 ? 2 : 3,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 1.5,
  children: items
      .map(
        (x) => AppCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(x.$2, style: AppTextStyles.title.copyWith(color: x.$3)),
              Text(
                x.$1,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      )
      .toList(),
);

class _ChartPlaceholder extends StatelessWidget {
  final String title;
  const _ChartPlaceholder({required this.title});
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.title),
        const SizedBox(height: 60),
        const Center(
          child: Icon(
            Icons.bar_chart_rounded,
            size: 56,
            color: AppColors.hydrationBlue,
          ),
        ),
      ],
    ),
  );
}

class _ListTile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  const _ListTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) => AppCard(
    child: Row(
      children: [
        Icon(icon, color: AppColors.brandPrimary),
        const SizedBox(width: AppSizes.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.label),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _VideoCard extends StatelessWidget {
  final String title;
  const _VideoCard({required this.title});
  @override
  Widget build(BuildContext context) => AppCard(
    child: Row(
      children: [
        Container(
          width: 86,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.surface3,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
          child: const Icon(
            Icons.play_circle_fill_rounded,
            color: AppColors.brandPrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.label),
              Text(
                'Perfect Form Guide · 04:20',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
