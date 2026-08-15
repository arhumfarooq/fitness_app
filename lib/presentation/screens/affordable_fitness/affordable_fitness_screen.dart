import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/data/repositories/exports.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';

class AffordableFitnessScreen extends StatelessWidget {
  const AffordableFitnessScreen({super.key});

  static const _equipment = [
    ['Water bottles', 'Dumbbells for arm exercises'],
    ['Backpack with books', 'Weighted vest for squats'],
    ['Towel', 'Resistance training & stretching'],
    ['Chair', 'Dips, step-ups, incline push-ups'],
    ['Wall', 'Wall sits, handstands, planks'],
    ['Stairs', 'Cardio, lunges, calf raises'],
  ];

  static const _benefits = [
    [
      Icons.bolt_rounded,
      'AI-Powered Plans',
      'Personalized workout routines tailored to your fitness level',
    ],
    [
      Icons.home_rounded,
      'Home Workouts',
      'Train anywhere, anytime with zero equipment',
    ],
    [
      Icons.people_rounded,
      'Community Support',
      'Join thousands achieving their goals at home',
    ],
    [
      Icons.star_rounded,
      '100% Free',
      'No hidden costs, no subscriptions required',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final workouts = WorkoutRepository.getHomeWorkouts();

    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const DarkBackButton(),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.affordableTitle,
                          style: AppTextStyles.h3.copyWith(color: Colors.white),
                        ),
                        Text(
                          AppStrings.affordableSub,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(AppSizes.cardPadMd),
                  decoration: BoxDecoration(
                    color: AppColors.overlay10,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                    border: Border.all(color: AppColors.border20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.overlay10,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMd,
                          ),
                          border: Border.all(color: AppColors.border20),
                        ),
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                          size: AppSizes.iconLg,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppStrings.everyoneDeserves,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppStrings.affordableDesc,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                AppSizes.screenPad,
                AppSizes.lg,
                AppSizes.screenPad,
                100,
              ),
              children: [
                // Benefits
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('What You Get', style: AppTextStyles.h4),
                      const SizedBox(height: 14),
                      ..._benefits.map(
                        (b) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4F4F5),
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.radiusMd,
                                  ),
                                ),
                                child: Icon(
                                  b[0] as IconData,
                                  color: AppColors.primary,
                                  size: AppSizes.iconMd,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      b[1] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      b[2] as String,
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Text('Free Weekly Plans', style: AppTextStyles.h4),
                const SizedBox(height: 12),

                ...workouts.map(
                  (w) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AppCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppSizes.radiusXl),
                                  topRight: Radius.circular(AppSizes.radiusXl),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: w.imageUrl,
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Color(0xCC000000),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        AppSizes.radiusXl.toDouble(),
                                      ),
                                      topRight: Radius.circular(
                                        AppSizes.radiusXl.toDouble(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 12,
                                left: 12,
                                child: _FreeBadge(),
                              ),
                              Positioned(
                                bottom: 12,
                                left: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      w.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      w.equipment,
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(AppSizes.cardPadMd),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      w.duration,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      '${w.exercises} exercises',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      w.difficulty,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                AppButton(
                                  label: AppStrings.startWorkoutBtn,
                                  height: AppSizes.btnMd,
                                  onPressed: () => ToastHelper.success(
                                    context,
                                    'Workout started!',
                                    description: '${w.name} · ${w.duration}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Equipment
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Household Items as Equipment',
                        style: AppTextStyles.h4,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Get creative! Here's how to use everyday items:",
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                      const SizedBox(height: 14),
                      ..._equipment.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color(0xFF1F2937)
                                  : const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusLg,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    e[0],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const Text(
                                  ' → ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e[1],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FreeBadge extends StatelessWidget {
  const _FreeBadge();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
    ),
    child: Text(
      AppStrings.freeLabel,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
