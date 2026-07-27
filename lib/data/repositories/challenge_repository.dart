import 'package:flutter/material.dart';
import '../models/exports.dart';

class ChallengeRepository {
  static List<ChallengeModel> getActiveChallenges() => [
        ChallengeModel(
          id: 1,
          name: '30-Day Plank Challenge',
          daysCompleted: 12,
          totalDays: 30,
          reward: 'Gold Badge',
          participants: 2843,
          icon: Icons.track_changes_rounded,
          gradientColors: [Colors.amber, Colors.orange],
          isActive: true,
        ),
        ChallengeModel(
          id: 2,
          name: '100 Push-ups Daily',
          daysCompleted: 5,
          totalDays: 14,
          reward: 'Strength Master',
          participants: 1567,
          icon: Icons.local_fire_department_rounded,
          gradientColors: [Colors.orange, Colors.deepOrange],
          isActive: true,
        ),
      ];

  static List<ChallengeModel> getAvailableChallenges() => [
        ChallengeModel(
          id: 3,
          name: 'Water Warrior',
          description: 'Drink 8 glasses of water daily for 21 days',
          daysCompleted: 0,
          totalDays: 21,
          reward: 'Hydration Hero Badge',
          participants: 5234,
          icon: Icons.emoji_events_rounded,
          gradientColors: [Colors.blue, Colors.lightBlue],
          difficulty: 'Easy',
        ),
        ChallengeModel(
          id: 4,
          name: '10K Steps Challenge',
          description: 'Walk 10,000 steps every day for a month',
          daysCompleted: 0,
          totalDays: 30,
          reward: 'Walking Champion',
          participants: 3891,
          icon: Icons.track_changes_rounded,
          gradientColors: [Colors.green, Colors.teal],
          difficulty: 'Medium',
        ),
        ChallengeModel(
          id: 5,
          name: 'Yoga Master',
          description: 'Complete 30 minutes of yoga daily for 15 days',
          daysCompleted: 0,
          totalDays: 15,
          reward: 'Zen Master Badge',
          participants: 2456,
          icon: Icons.workspace_premium_rounded,
          gradientColors: [Colors.purple, Colors.deepPurple],
          difficulty: 'Easy',
        ),
      ];

  static List<AchievementModel> getAchievements() => const [
        AchievementModel(name: 'First Workout', date: 'May 15, 2026', emoji: '🏆'),
        AchievementModel(name: '7-Day Streak', date: 'May 22, 2026', emoji: '🔥'),
        AchievementModel(name: 'Weight Loss Warrior', date: 'June 1, 2026', emoji: '⭐'),
        AchievementModel(name: 'Consistency King', date: 'June 10, 2026', emoji: '👑'),
      ];
}
