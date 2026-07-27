import 'package:flutter/material.dart';

class WorkoutCategory {
  final int id;
  final String name;
  final int exercises;
  final String imageUrl;
  final Color color;
  final IconData icon;

  const WorkoutCategory({
    required this.id,
    required this.name,
    required this.exercises,
    required this.imageUrl,
    required this.color,
    required this.icon,
  });

  String get difficulty {
    if (id % 3 == 0) return 'Easy';
    if (id % 2 == 0) return 'Medium';
    return 'Hard';
  }

  int get durationMinutes => 20 + id * 5;
}

class ExerciseModel {
  final int id;
  final String name;
  final String sets;
  final String reps;
  final String rest;
  final String instructions;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.instructions,
  });
}

class HomeWorkout {
  final int id;
  final String name;
  final String duration;
  final int exercises;
  final String equipment;
  final String difficulty;
  final String imageUrl;

  const HomeWorkout({
    required this.id,
    required this.name,
    required this.duration,
    required this.exercises,
    required this.equipment,
    required this.difficulty,
    required this.imageUrl,
  });
}
