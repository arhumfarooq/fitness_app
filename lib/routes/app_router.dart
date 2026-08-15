import 'package:go_router/go_router.dart';

import 'package:fitness_app/presentation/screens/exports.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (ctx, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (ctx, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (ctx, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (ctx, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.workouts,
        builder: (ctx, state) => const WorkoutLibraryScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.exercise}/:id',
        builder: (ctx, state) => ExerciseDetailsScreen(
          categoryId: int.parse(state.pathParameters['id'] ?? '1'),
        ),
      ),
      GoRoute(
        path: AppRoutes.meals,
        builder: (ctx, state) => const MealPlannerScreen(),
      ),
      GoRoute(
        path: AppRoutes.progress,
        builder: (ctx, state) => const ProgressScreen(),
      ),
      GoRoute(
        path: AppRoutes.challenges,
        builder: (ctx, state) => const ChallengesScreen(),
      ),
      GoRoute(
        path: AppRoutes.affordable,
        builder: (ctx, state) => const AffordableFitnessScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (ctx, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (ctx, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.personalInfo,
        builder: (_, __) => const PersonalInfoScreen(),
      ),
      GoRoute(path: AppRoutes.goals, builder: (_, __) => const GoalScreen()),
      GoRoute(path: AppRoutes.steps, builder: (_, __) => const StepsScreen()),
      GoRoute(
        path: AppRoutes.aiVideos,
        builder: (_, __) => const AiVideosScreen(),
      ),
      GoRoute(
        path: AppRoutes.scanner,
        builder: (_, __) => const CalorieScannerScreen(),
      ),
      GoRoute(
        path: AppRoutes.scanResult,
        builder: (_, __) => const ScanResultScreen(),
      ),
      GoRoute(
        path: AppRoutes.calorieSummary,
        builder: (_, __) => const CalorieSummaryScreen(),
      ),
      GoRoute(
        path: AppRoutes.water,
        builder: (_, __) => const WaterTrackerScreen(),
      ),
      GoRoute(
        path: AppRoutes.sleep,
        builder: (_, __) => const SleepTrackerScreen(),
      ),
      GoRoute(
        path: AppRoutes.achievements,
        builder: (_, __) => const AchievementsScreen(),
      ),
      GoRoute(
        path: AppRoutes.workoutPlan,
        builder: (_, __) => const WorkoutPlanScreen(),
      ),
      GoRoute(
        path: AppRoutes.editGoal,
        builder: (_, __) => const EditGoalScreen(),
      ),
      GoRoute(
        path: AppRoutes.premium,
        builder: (_, __) => const PremiumScreen(),
      ),
    ],
  );
}

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const personalInfo = '/personal-info';
  static const goals = '/goals';
  static const home = '/home';
  static const workouts = '/workouts';
  static const exercise = '/exercise';
  static const meals = '/meals';
  static const progress = '/progress';
  static const challenges = '/challenges';
  static const affordable = '/affordable-fitness';
  static const notifications = '/notifications';
  static const profile = '/profile';
  static const steps = '/steps';
  static const aiVideos = '/ai-videos';
  static const scanner = '/calorie-scanner';
  static const scanResult = '/scan-result';
  static const calorieSummary = '/calorie-summary';
  static const water = '/water';
  static const sleep = '/sleep';
  static const achievements = '/achievements';
  static const workoutPlan = '/workout-plan';
  static const editGoal = '/edit-goal';
  static const premium = '/premium';
}
