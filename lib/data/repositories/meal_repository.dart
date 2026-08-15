import 'package:fitness_app/data/models/exports.dart';

class MealRepository {
  static List<MealModel> getMeals() => [
    MealModel(
      id: 1,
      name: 'Breakfast',
      time: '7:00 AM',
      calories: 420,
      protein: '28g',
      carbs: '45g',
      fat: '14g',
      items: ['Oatmeal with berries', 'Greek yogurt', 'Black coffee'],
      imageUrl:
          'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800',
    ),
    MealModel(
      id: 2,
      name: 'Lunch',
      time: '12:30 PM',
      calories: 580,
      protein: '42g',
      carbs: '52g',
      fat: '18g',
      items: [
        'Grilled chicken breast',
        'Brown rice',
        'Mixed vegetables',
        'Olive oil',
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
    ),
    MealModel(
      id: 3,
      name: 'Dinner',
      time: '7:00 PM',
      calories: 520,
      protein: '38g',
      carbs: '40g',
      fat: '20g',
      items: ['Salmon fillet', 'Sweet potato', 'Steamed broccoli', 'Lemon'],
      imageUrl:
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800',
    ),
  ];

  static List<NutritionStat> getNutritionStats() => const [
    NutritionStat(label: 'Calories', current: 1520, goal: 2000, percent: 0.76),
    NutritionStat(label: 'Protein', current: 108, goal: 150, percent: 0.72),
    NutritionStat(label: 'Carbs', current: 137, goal: 200, percent: 0.69),
    NutritionStat(label: 'Fat', current: 52, goal: 70, percent: 0.74),
  ];
}
