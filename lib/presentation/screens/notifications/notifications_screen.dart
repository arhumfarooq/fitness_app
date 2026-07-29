import 'package:fitness_app/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../core/exports.dart';
import '../../../data/models/exports.dart';
import '../../widgets/exports.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final List<NotificationModel> _items = [
    NotificationModel(
        id: 1,
        title: 'Workout Reminder',
        body: "Time for your Full Body HIIT! You're on a 12-day streak 💪",
        time: '2 min ago',
        icon: Icons.fitness_center_rounded,
        color: AppColors.primary),
    NotificationModel(
        id: 2,
        title: 'AI Coach Suggestion',
        body: 'Based on your progress, try adding 5 more push-up reps today!',
        time: '1h ago',
        icon: Icons.auto_awesome_rounded,
        color: AppColors.purple),
    NotificationModel(
        id: 3,
        title: 'Water Goal Achieved!',
        body: "You've completed your 8 glasses water goal today! 🥤",
        time: '3h ago',
        icon: Icons.water_drop_rounded,
        color: AppColors.blue),
    NotificationModel(
        id: 4,
        title: 'Challenge Update',
        body: '18 days left in the 30-Day Plank Challenge. Keep going!',
        time: 'Yesterday',
        icon: Icons.track_changes_rounded,
        color: Colors.amber,
        isRead: true),
    NotificationModel(
        id: 5,
        title: 'Meal Reminder',
        body: "Don't forget your post-workout protein! Aim for 30g within 45 min.",
        time: 'Yesterday',
        icon: Icons.restaurant_rounded,
        color: AppColors.orange,
        isRead: true),
  ];

  @override
  Widget build(BuildContext context) {
    final unread = _items.where((n) => !n.isRead).length;

    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Row(
              children: [
                const DarkBackButton(),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.notificationsTitle,
                          style: AppTextStyles.h3.copyWith(color: Colors.white)),
                      if (unread > 0)
                        Text('$unread unread',
                            style: TextStyle(color: Colors.grey[400], fontSize: 11)),
                    ],
                  ),
                ),
                if (unread > 0)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        for (final n in _items) n.isRead = true;
                      });
                    },
                    child: const Text('Mark all read',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding:  EdgeInsets.fromLTRB(
                  AppSizes.screenPad, AppSizes.lg, AppSizes.screenPad, 100),
              itemCount: _items.length,
              itemBuilder: (ctx, i) {
                final n = _items[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => n.isRead = true),
                    child: Container(
                      padding:  EdgeInsets.all(AppSizes.cardPadMd),
                      decoration: BoxDecoration(
                        color: n.isRead
                            ? (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.cardDark
                                : AppColors.white)
                            : (Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF1F2937)
                                : const Color(0xFFF8FAFC)),
                        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                        border: Border.all(
                          color: n.isRead
                              ? (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight)
                              : n.color.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: n.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                            ),
                            child: Icon(n.icon, color: n.color, size: AppSizes.iconMd),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Expanded(
                                    child: Text(n.title,
                                        style: TextStyle(
                                            fontWeight: n.isRead
                                                ? FontWeight.w500
                                                : FontWeight.w700,
                                            fontSize: 14)),
                                  ),
                                  if (!n.isRead)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: n.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ]),
                                const SizedBox(height: 4),
                                Text(n.body,
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12, height: 1.4)),
                                const SizedBox(height: 6),
                                Text(n.time,
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
