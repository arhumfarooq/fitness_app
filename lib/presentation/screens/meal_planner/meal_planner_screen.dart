import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../core/exports.dart';
import '../../../data/repositories/exports.dart';
import '../../widgets/exports.dart';

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meals = MealRepository.getMeals();
    final nutrition = MealRepository.getNutritionStats();

    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Row(
              children: [
                const DarkBackButton(),
                const SizedBox(width: 14),
                Text(AppStrings.mealPlanner,
                    style: AppTextStyles.h3.copyWith(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                  AppSizes.screenPad, AppSizes.lg, AppSizes.screenPad, 100),
              children: [
                // Nutrition summary
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Today's Nutrition", style: AppTextStyles.h4),
                      const SizedBox(height: 4),
                      Text('1,520 / 2,000 kcal',
                          style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                      const SizedBox(height: 16),
                      ...nutrition.map((n) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(n.label,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                    Text('${n.current}g / ${n.goal}g',
                                        style: TextStyle(
                                            color: Colors.grey[500], fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: n.percent,
                                    minHeight: 6,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: const AlwaysStoppedAnimation(
                                        AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Text("Today's Meals", style: AppTextStyles.h4),
                const SizedBox(height: 12),

                ...meals.map((meal) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSizes.radiusXl),
                                topRight: Radius.circular(AppSizes.radiusXl),
                              ),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: meal.imageUrl,
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.transparent, Color(0xCC000000)],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    left: 12,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(meal.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18)),
                                        Text(meal.time,
                                            style: TextStyle(
                                                color: Colors.grey[300],
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.radiusFull),
                                      ),
                                      child: Text('${meal.calories} kcal',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppSizes.cardPadMd),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _MacroChip('Protein', meal.protein, AppColors.blue),
                                      _MacroChip('Carbs', meal.carbs, AppColors.orange),
                                      _MacroChip('Fat', meal.fat, AppColors.purple),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Divider(height: 1),
                                  const SizedBox(height: 10),
                                  ...meal.items.map((item) => Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Row(children: [
                                          const Icon(Icons.fiber_manual_record_rounded,
                                              size: 8, color: AppColors.primary),
                                          const SizedBox(width: 8),
                                          Text(item,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[700])),
                                        ]),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const MobileNavBar(),
        ],
      ),
    );
  }
}

class _MacroChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MacroChip(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) => Column(children: [
        Text(value,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w700, fontSize: 16)),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
      ]);
}
