import '../model/habit_model.dart';

class StreakController {
  int calculateStreak(HabitModel habit) {
    if(habit.lastCompleted == null) {
      return 1; // Starting a new streak
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = DateTime(habit.lastCompleted!.year, habit.lastCompleted!.month, habit.lastCompleted!.day);

    final difference = habit.lastCompleted != null ? today.difference(last) : null;

    int streak = habit.streak;

    switch (habit.frequency) {
      case 'daily':
        if (difference != null && difference.inDays == 1) {
          streak++;
        } else if (difference != null && difference.inDays > 1) {
          streak = 1;
        }
        break;
      case 'weekly':
        if (difference != null && difference.inDays >= 7 && difference.inDays < 14) {
          streak++;
        } else if (difference != null && difference.inDays >= 14) {
          streak = 1;
        }
        break;
      case 'monthly':
        if (difference != null && difference.inDays >= 30 && difference.inDays < 60) {
          streak++;
        } else if (difference != null && difference.inDays >= 60) {
          streak = 1;
        }
        break;
      default:
        if (difference != null && difference.inDays == 1) {
          streak++;
        } else if (difference != null && difference.inDays > 1) {
          streak = 1;
        }
    }
    return streak;
  }
}