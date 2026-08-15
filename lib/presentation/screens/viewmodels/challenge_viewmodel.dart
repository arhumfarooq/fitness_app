import 'package:get/get.dart';
import 'package:fitness_app/data/models/exports.dart';
import 'package:fitness_app/data/repositories/exports.dart';

class ChallengeViewModel extends GetxController {
  final active = <ChallengeModel>[].obs;
  final available = <ChallengeModel>[].obs;
  final joinedIds = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    active.assignAll(ChallengeRepository.getActiveChallenges());
    available.assignAll(ChallengeRepository.getAvailableChallenges());
  }

  List<AchievementModel> get achievements =>
      ChallengeRepository.getAchievements();

  bool isJoined(int id) => joinedIds.contains(id);

  void joinChallenge(int id) => joinedIds.add(id);

  void unjoinChallenge(int id) => joinedIds.remove(id);

  void logDay(int id) {
    active.value = active.map((c) {
      if (c.id == id) {
        return c.copyWith(
          daysCompleted: (c.daysCompleted + 1).clamp(0, c.totalDays),
        );
      }
      return c;
    }).toList();
  }

  void undoLogDay(int id, int prevDays) {
    active.value = active.map((c) {
      if (c.id == id) return c.copyWith(daysCompleted: prevDays);
      return c;
    }).toList();
  }
}
