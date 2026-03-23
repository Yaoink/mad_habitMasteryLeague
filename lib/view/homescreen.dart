import 'package:flutter/material.dart';
import '../controller/database_helper.dart';
import '../model/habit_model.dart';
import './add_habit.dart';
import './edit_habit.dart';
import './habit_deets.dart';
import '../controller/streak.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HabitModel> habits = [];
  StreakController streakController = StreakController();

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
            onTap: () async { //navigates to screen that displays full details of habit
              final dbHabit = await DatabaseHelper.instance.getItem(habit.id!);

              if (dbHabit == null) return;

              final fullHabit = HabitModel.fromMap(dbHabit);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitDeets(habit: fullHabit),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Streak: ${habit.streak}'),
                //updates streak count and last completed date when check button is pressed
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () async {
                    final newStreak = streakController.calculateStreak(habit);

                    habit.streak = newStreak;
                    habit.lastCompleted = DateTime.now();

                    await DatabaseHelper.instance.updateItem(habit.id!, habit.toMap());
                    await _loadHabits();

                    print("OLD: ${habit.streak}, NEW: $newStreak");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditHabit(habit: habit)),
                    );
                    await _loadHabits();
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteItem(habit.id!);
                    await _loadHabits();
                  },
                ),
              ],
            ),
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

        child: Row(
          children: [
            Icon(Icons.add),
            Text('Add New Habit'),
          ],
        ),
      )
    );
  }
}