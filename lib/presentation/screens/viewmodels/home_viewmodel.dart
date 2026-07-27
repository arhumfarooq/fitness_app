import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final waterCount = 6.obs;

  void logWater() {
    if (waterCount.value < 10) waterCount.value++;
  }

  void undoWater() {
    if (waterCount.value > 0) waterCount.value--;
  }

  double get waterProgress => waterCount.value / 8;

  final stats = [
    StatData(title: 'Steps', value: '8,547', subtitle: 'Steps / 10,000', progress: 0.85),
    StatData(title: 'Calories', value: '420', subtitle: 'Calories / 600', progress: 0.70),
    StatData(title: 'Sleep', value: '7.5h', subtitle: 'Sleep / 8h', progress: 0.94),
  ];
}

class StatData {
  final String title;
  final String value;
  final String subtitle;
  final double progress;
  const StatData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.progress,
  });
}
