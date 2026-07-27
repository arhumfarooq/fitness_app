import 'package:get/get.dart';

class ProgressViewModel extends GetxController {
  final tabIndex = 0.obs;

  void setTab(int index) => tabIndex.value = index;

  final weightData = [
    {'week': 'W1', 'weight': 85.0},
    {'week': 'W2', 'weight': 84.5},
    {'week': 'W3', 'weight': 84.0},
    {'week': 'W4', 'weight': 83.2},
    {'week': 'W5', 'weight': 82.8},
    {'week': 'W6', 'weight': 82.5},
  ];

  final workoutData = [
    {'day': 'Mon', 'minutes': 45},
    {'day': 'Tue', 'minutes': 30},
    {'day': 'Wed', 'minutes': 60},
    {'day': 'Thu', 'minutes': 40},
    {'day': 'Fri', 'minutes': 55},
    {'day': 'Sat', 'minutes': 50},
    {'day': 'Sun', 'minutes': 35},
  ];
}
