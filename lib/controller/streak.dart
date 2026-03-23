import '../model/habit_model.dart';

class StreakController {
  int streak = 0;
  DateTime? lastCompleted;

  int calculateStreak(HabitModel habit) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = DateTime(habit.lastCompleted!.year, habit.lastCompleted!.month, habit.lastCompleted!.day);

    final difference = habit.lastCompleted != null ? today.difference(last) : null;

    switch (habit.frequency) {
      case 'daily':
        if (difference != null && difference.inDays == 1) {
          streak++;
        } else if (difference != null && difference.inDays > 1) {
          streak = 0;
        }
        break;
      case 'weeekly':
        if (difference != null && difference.inDays >= 7 && difference.inDays < 14) {
          streak++;
        } else if (difference != null && difference.inDays >= 14) {
          streak = 0;
        }
        break;
      case 'monthly':
        if (difference != null && difference.inDays >= 30 && difference.inDays < 60) {
          streak++;
        } else if (difference != null && difference.inDays >= 60) {
          streak = 0;
        }
        break;
      default:
        if (difference != null && difference.inDays == 1) {
          streak++;
        } else if (difference != null && difference.inDays > 1) {
          streak = 0;
        }
    }
    return streak;
  }
}