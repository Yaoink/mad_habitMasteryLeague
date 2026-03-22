import 'package:flutter/material.dart';
import 'package:project1/model/habit_model.dart';

class HabitDeets extends StatelessWidget {
  final HabitModel habit;

  const HabitDeets({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Description: \n${habit.description}'),
            Text('Reward Requirement: \n${habit.rewardReq}'),
            Text('Penalty Requirement: \n${habit.penaltyReq}'),
            Text('Frequency: \n${habit.frequency}'),
            Text('Current Streak: \n${habit.streak}'),
          ],
        ),
      ),
    );
  }
}