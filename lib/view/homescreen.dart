import 'package:flutter/material.dart';
import 'package:project1/model/database_helper.dart';
import 'package:project1/model/habit_model.dart';
import 'package:project1/view/add_habit.dart';
import 'package:project1/view/edit_habit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HabitModel> habits = [];

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final dbHelper = DatabaseHelper.instance;
    final habitMaps = await dbHelper.getAllItems();
    setState(() {
      habits = habitMaps.map((map) => HabitModel.fromMap(map)).toList();
    });
    print("Loaded habits: $habits");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return ListTile(
            title: Text(habit.name),
            subtitle: Text(habit.description),
            trailing: Text('Streak: ${habit.streak}'),

            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditHabit(habit: habit)),
              );
              await _loadHabits();
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabit()),
          );
          await _loadHabits(); // Refresh habits after adding new one
        },

        child: const Icon(Icons.add),
      )
    );
  }
}