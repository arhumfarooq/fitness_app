import 'package:get/get.dart';
import 'package:fitness_app/presentation/screens/viewmodels/exports.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeViewModel>(() => ThemeViewModel(), fenix: true);
    Get.lazyPut<LoginViewModel>(() => LoginViewModel(), fenix: true);
    Get.lazyPut<SignUpViewModel>(() => SignUpViewModel(), fenix: true);
    Get.lazyPut<HomeViewModel>(() => HomeViewModel(), fenix: true);
    Get.lazyPut<WorkoutLibraryViewModel>(
      () => WorkoutLibraryViewModel(),
      fenix: true,
    );
    Get.lazyPut<ExerciseDetailsViewModel>(
      () => ExerciseDetailsViewModel(),
      fenix: true,
    );
    Get.lazyPut<ProgressViewModel>(() => ProgressViewModel(), fenix: true);
    Get.lazyPut<ChallengeViewModel>(() => ChallengeViewModel(), fenix: true);
    Get.lazyPut<ProfileViewModel>(() => ProfileViewModel(), fenix: true);
  }
}
