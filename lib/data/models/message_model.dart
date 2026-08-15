class MessageModel {
  final String id;
  final String text;
  final bool isAI;
  final DateTime timestamp;

  const MessageModel({
    required this.id,
    required this.text,
    required this.isAI,
    required this.timestamp,
  });

  static MessageModel greeting() => MessageModel(
    id: '1',
    text:
        "Hi! I'm your AI Fitness Coach 💪 I'm here to help you achieve your fitness goals. What would you like to know?",
    isAI: true,
    timestamp: DateTime.now(),
  );
}
