class UserModel {
  final String id;
  final String name;
  final String email;
  final String height;
  final String weight;
  final String goal;
  final String fitnessLevel;
  final String joinDate;
  final bool isPremium;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.height,
    required this.weight,
    required this.goal,
    required this.fitnessLevel,
    required this.joinDate,
    this.isPremium = true,
  });

  static const sample = UserModel(
    id: '1',
    name: 'Alex Johnson',
    email: 'alex.johnson@email.com',
    height: '175 cm',
    weight: '82.5 kg',
    goal: 'Lose Weight',
    fitnessLevel: 'Intermediate',
    joinDate: 'March 2026',
    isPremium: true,
  );
}
