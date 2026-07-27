import 'package:get/get.dart';
import '../../../data/models/exports.dart';
import '../../../data/repositories/exports.dart';

class WorkoutLibraryViewModel extends GetxController {
  final _all = WorkoutRepository.getCategories();
  final query = ''.obs;

  List<WorkoutCategory> get filtered => query.value.isEmpty
      ? _all
      : _all
          .where((c) =>
              c.name.toLowerCase().contains(query.value.toLowerCase()))
          .toList();

  void search(String q) => query.value = q;
}

class ExerciseDetailsViewModel extends GetxController {
  final currentSet = 1.obs;
  final currentExercise = 0.obs;
  final isResting = false.obs;

  List<ExerciseModel> getExercises(int categoryId) =>
      WorkoutRepository.getExercises(categoryId);

  void nextSet() => currentSet.value++;

  void nextExercise() {
    currentExercise.value++;
    currentSet.value = 1;
  }

  void toggleRest() => isResting.value = !isResting.value;
}
