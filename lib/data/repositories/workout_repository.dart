import 'package:flutter/material.dart';
import 'package:fitness_app/data/models/exports.dart';

class WorkoutRepository {
  static List<WorkoutCategory> getCategories() => [
    WorkoutCategory(
      id: 1,
      name: 'Home Workout',
      exercises: 45,
      imageUrl:
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=800',
      color: Colors.blue,
      icon: Icons.home_rounded,
    ),
    WorkoutCategory(
      id: 2,
      name: 'Gym Workout',
      exercises: 68,
      imageUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
      color: const Color(0xFF18181B),
      icon: Icons.fitness_center_rounded,
    ),
    WorkoutCategory(
      id: 3,
      name: 'Weight Loss',
      exercises: 52,
      imageUrl:
          'https://images.unsplash.com/photo-1571008887538-b36bb32f4571?w=800',
      color: Colors.orange,
      icon: Icons.trending_down_rounded,
    ),
    WorkoutCategory(
      id: 4,
      name: 'Muscle Gain',
      exercises: 61,
      imageUrl:
          'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=800',
      color: Colors.purple,
      icon: Icons.trending_up_rounded,
    ),
    WorkoutCategory(
      id: 5,
      name: 'Cardio',
      exercises: 38,
      imageUrl:
          'https://images.unsplash.com/photo-1571008887538-b36bb32f4571?w=800',
      color: Colors.red,
      icon: Icons.favorite_rounded,
    ),
    WorkoutCategory(
      id: 6,
      name: 'Yoga',
      exercises: 42,
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800',
      color: Colors.pink,
      icon: Icons.self_improvement_rounded,
    ),
    WorkoutCategory(
      id: 7,
      name: 'HIIT',
      exercises: 35,
      imageUrl:
          'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=800',
      color: Colors.amber,
      icon: Icons.bolt_rounded,
    ),
  ];

  static List<ExerciseModel> getExercises(int categoryId) => [
    const ExerciseModel(
      id: 1,
      name: 'Push-ups',
      sets: '3',
      reps: '15',
      rest: '60s',
      instructions:
          'Keep your body straight. Lower chest to floor, then push back up.',
    ),
    const ExerciseModel(
      id: 2,
      name: 'Squats',
      sets: '4',
      reps: '20',
      rest: '60s',
      instructions:
          'Feet shoulder-width apart. Lower until thighs are parallel to floor.',
    ),
    const ExerciseModel(
      id: 3,
      name: 'Plank',
      sets: '3',
      reps: '45s',
      rest: '45s',
      instructions:
          'Hold straight body position on forearms and toes. Keep core tight.',
    ),
    const ExerciseModel(
      id: 4,
      name: 'Lunges',
      sets: '3',
      reps: '12 each',
      rest: '60s',
      instructions:
          'Step forward and lower back knee toward floor. Keep front knee over ankle.',
    ),
    const ExerciseModel(
      id: 5,
      name: 'Burpees',
      sets: '3',
      reps: '10',
      rest: '90s',
      instructions:
          'Start standing, drop to push-up, jump feet forward, jump up with arms overhead.',
    ),
  ];

  static List<HomeWorkout> getHomeWorkouts() => [
    const HomeWorkout(
      id: 1,
      name: 'Bodyweight Basics',
      duration: '20 min',
      exercises: 8,
      equipment: 'None required',
      difficulty: 'Beginner',
      imageUrl:
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=800',
    ),
    const HomeWorkout(
      id: 2,
      name: 'Household Items HIIT',
      duration: '25 min',
      exercises: 10,
      equipment: 'Water bottles, towel',
      difficulty: 'Intermediate',
      imageUrl:
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=800',
    ),
    const HomeWorkout(
      id: 3,
      name: 'No Equipment Strength',
      duration: '30 min',
      exercises: 12,
      equipment: 'Just your body',
      difficulty: 'All levels',
      imageUrl:
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=800',
    ),
  ];
}
