import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/exports.dart';

class AICoachViewModel extends GetxController {
  final messages = <MessageModel>[MessageModel.greeting()].obs;
  final isTyping = false.obs;
  final inputCtrl = TextEditingController();

  static const quickPrompts = [
    'Weight loss plan',
    'Pre-workout meal',
    'Muscle at home',
    'Better sleep tips',
  ];

  Future<void> send({String? text}) async {
    final msg = (text ?? inputCtrl.text).trim();
    if (msg.isEmpty) return;

    inputCtrl.clear();
    messages.add(MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: msg,
      isAI: false,
      timestamp: DateTime.now(),
    ));
    isTyping.value = true;

    await Future.delayed(const Duration(milliseconds: 1400));

    isTyping.value = false;
    messages.add(MessageModel(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      text: _getResponse(msg),
      isAI: true,
      timestamp: DateTime.now(),
    ));
  }

  void clearChat() {
    messages
      ..clear()
      ..add(MessageModel.greeting());
  }

  String _getResponse(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('weight loss') || lower.contains('weight loss plan')) {
      return 'Great goal! For weight loss, I recommend:\n\n1. Cardio 4x/week (30-45 min)\n2. Strength training 3x/week\n3. Calorie deficit of 300-500 calories\n4. High protein diet (1.6g per kg bodyweight)\n\nWould you like me to create a detailed workout plan?';
    } else if (lower.contains('eat') || lower.contains('meal') || lower.contains('pre-workout')) {
      return 'Before a workout, aim for:\n\n🍌 Simple carbs (banana, oatmeal)\n🥚 Moderate protein (Greek yogurt, eggs)\n⏰ 1-2 hours before exercise\n💧 Stay hydrated\n\nAfter workout, focus on protein + carbs within 30-45 minutes!';
    } else if (lower.contains('muscle') || lower.contains('home')) {
      return 'Building muscle at home is definitely possible!\n\n💪 Bodyweight exercises (push-ups, squats, lunges)\n🏋️ Progressive overload\n🍗 High protein intake\n😴 7-9 hours sleep\n\nI can create a 4-week home workout plan for you. Interested?';
    } else if (lower.contains('sleep')) {
      return 'Better sleep = better gains!\n\n🌙 Fixed sleep/wake time (even weekends)\n📵 No screens 30 min before bed\n🌡️ Keep room cool (65-68°F)\n🧘 5-min wind-down stretch\n\nAim for 7-9 hours. Poor sleep raises cortisol and stalls muscle recovery.';
    }
    return "That's a great question! Based on your fitness profile, I recommend focusing on consistency and progressive overload. Would you like me to create a personalized plan?";
  }

  @override
  void onClose() {
    inputCtrl.dispose();
    super.onClose();
  }
}
