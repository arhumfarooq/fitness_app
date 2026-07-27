import 'package:go_router/go_router.dart';

import '../presentation/screens/exports.dart';

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
        path: AppRoutes.aiCoach,
        builder: (ctx, state) => const AICoachScreen(),
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
    ],
  );
}

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const aiCoach = '/ai-coach';
  static const workouts = '/workouts';
  static const exercise = '/exercise';
  static const meals = '/meals';
  static const progress = '/progress';
  static const challenges = '/challenges';
  static const affordable = '/affordable-fitness';
  static const notifications = '/notifications';
  static const profile = '/profile';
}
