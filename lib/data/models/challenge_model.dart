import 'package:flutter/material.dart';

class ChallengeModel {
  final int id;
  final String name;
  final String? description;
  final int daysCompleted;
  final int totalDays;
  final String reward;
  final int participants;
  final IconData icon;
  final List<Color> gradientColors;
  final String? difficulty;
  final bool isActive;

  const ChallengeModel({
    required this.id,
    required this.name,
    this.description,
    required this.daysCompleted,
    required this.totalDays,
    required this.reward,
    required this.participants,
    required this.icon,
    required this.gradientColors,
    this.difficulty,
    this.isActive = false,
  });

  double get progressPercent => daysCompleted / totalDays;
  int get daysLeft => totalDays - daysCompleted;
  bool get isComplete => daysCompleted >= totalDays;

  ChallengeModel copyWith({int? daysCompleted}) => ChallengeModel(
        id: id,
        name: name,
        description: description,
        daysCompleted: daysCompleted ?? this.daysCompleted,
        totalDays: totalDays,
        reward: reward,
        participants: participants,
        icon: icon,
        gradientColors: gradientColors,
        difficulty: difficulty,
        isActive: isActive,
      );
}

class AchievementModel {
  final String name;
  final String date;
  final String emoji;

  const AchievementModel({
    required this.name,
    required this.date,
    required this.emoji,
  });
}
