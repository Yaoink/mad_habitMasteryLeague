import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/model/database_helper.dart';
import 'package:project1/model/habit_model.dart';

class EditHabit extends StatefulWidget {
  final HabitModel habit;

  const EditHabit({super.key, required this.habit});

  @override
  State<EditHabit> createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit> {
  late TextEditingController habitNameController;
  late TextEditingController descriptionController;
  late TextEditingController rewardController;
  late TextEditingController penaltyController;
  late TextEditingController frequencyController;

  @override
  void initState() {
    super.initState();
    
    habitNameController = TextEditingController(text: widget.habit.name);
    descriptionController = TextEditingController(text: widget.habit.description);
    rewardController = TextEditingController(text: widget.habit.rewardReq);
    penaltyController = TextEditingController(text: widget.habit.penaltyReq);
    frequencyController = TextEditingController(text: widget.habit.frequency);
  }

  @override
  void dispose() {
    habitNameController.dispose();
    descriptionController.dispose();
    rewardController.dispose();
    penaltyController.dispose();
    frequencyController.dispose();
    super.dispose();
  }

  void updateHabit() async {
    final updatedHabit = {
      'name': habitNameController.text,
      'description': descriptionController.text,
      'rewardReq': rewardController.text,
      'penaltyReq': penaltyController.text,
      'frequency': frequencyController.text,
    };

    await DatabaseHelper.instance.updateItem(
      widget.habit.id!,
      updatedHabit,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Habit')),
      body: Column(
        children: [
          TextField(controller: habitNameController),
          TextField(controller: descriptionController),
          TextField(controller: rewardController),
          TextField(controller: penaltyController),
          TextField(controller: frequencyController),

          ElevatedButton(
            onPressed: updateHabit,
            child: const Text("Update Habit"),
          ),
        ],
      ),
    );
  }
}