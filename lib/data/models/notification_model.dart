import 'package:flutter/material.dart';

class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color color;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.color,
    this.isRead = false,
  });
}
