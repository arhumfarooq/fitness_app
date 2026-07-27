class MealModel {
  final int id;
  final String name;
  final String time;
  final int calories;
  final String protein;
  final String carbs;
  final String fat;
  final List<String> items;
  final String imageUrl;

  const MealModel({
    required this.id,
    required this.name,
    required this.time,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.items,
    required this.imageUrl,
  });
}

class NutritionStat {
  final String label;
  final int current;
  final int goal;
  final double percent;

  const NutritionStat({
    required this.label,
    required this.current,
    required this.goal,
    required this.percent,
  });
}
