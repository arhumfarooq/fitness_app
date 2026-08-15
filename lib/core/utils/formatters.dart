class Formatters {
  static String time(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  static String date(DateTime dt) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = monthNames[dt.month - 1];
    return '$month ${dt.day}, ${dt.year}';
  }

  static String compactNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }

  static String percent(double value, double max) {
    if (max == 0) return '0%';
    return '${((value / max) * 100).round()}%';
  }

  static String daysLeft(int completed, int total) {
    final left = total - completed;
    return '$left days left';
  }
}
