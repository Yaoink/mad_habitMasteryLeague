class HabitModel {
  int? id;
  String name;
  String description;
  String rewardReq;
  String penaltyReq;
  String frequency;
  int streak;

  HabitModel({
    this.id,
    required this.name,
    required this.description,
    required this.rewardReq,
    required this.penaltyReq,
    required this.frequency,
    this.streak = 0,
  });

  // Convert HabitModel to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rewardReq': rewardReq,
      'penaltyReq': penaltyReq,
      'frequency': frequency,
      'streak': streak,
    };
  }

  // Create HabitModel from Map retrieved from database
  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      rewardReq: map['rewardReq'],
      penaltyReq: map['penaltyReq'],
      frequency: map['frequency'],
      streak: map['streak'],
    );
  }
  @override
  String toString() {
    return 'HabitModel{id: $id, name: $name, description: $description, rewardReq: $rewardReq, penaltyReq: $penaltyReq, frequency: $frequency, streak: $streak}';
  }
}

