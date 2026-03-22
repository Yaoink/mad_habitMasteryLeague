import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/model/database_helper.dart';


class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final habitNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final rewardController = TextEditingController();
  final penaltyController = TextEditingController();
  final frequencyController = TextEditingController();

  @override
  void dispose() {
    habitNameController.dispose();
    descriptionController.dispose();
    rewardController.dispose();
    penaltyController.dispose();
    frequencyController.dispose();
    super.dispose();
  }

  void saveHabit() async {
  final habit = {
    'name': habitNameController.text,
    'description': descriptionController.text,
    'rewardReq': rewardController.text,
    'penaltyReq': penaltyController.text,
    'frequency': frequencyController.text,
  };

  await DatabaseHelper.instance.createItem(habit);

  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: habitNameController,
              decoration: const InputDecoration(labelText: 'Habit Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: rewardController,
              decoration: const InputDecoration(labelText: 'Reward Requirement'),
            ),
            TextField(
              controller: penaltyController,
              decoration: const InputDecoration(labelText: 'Penalty Requirement'),
            ),
            TextField(
              controller: frequencyController,
              decoration: const InputDecoration(labelText: 'Frequency'),
            ),
            ElevatedButton(
            onPressed: saveHabit,
            child: const Text('Save Habit'),
            ),
          ],
        ),
      ),
    );
  }
}
