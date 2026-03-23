class StreakController {
  int streak = 0;
  DateTime? lastCompleted;

  int calculateStreak(String frequency) {
    final now = DateTime.now();
    final difference = lastCompleted != null ? now.difference(lastCompleted!) : null;

    switch (frequency) {
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