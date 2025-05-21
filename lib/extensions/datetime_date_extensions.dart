import '../enums/date_range_type.dart';

extension RelativeTime on DateTime {
  /// Returns a human-readable relative time string (e.g., "5 minutes ago")
  String relativeTime() {
    Duration difference = DateTime.now().difference(this);
    if (difference.inSeconds < 60) {
      return "just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} ${difference.inMinutes == 1 ? "minute" : "minutes"} ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} ${difference.inHours == 1 ? "hour" : "hours"} ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} ${difference.inDays == 1 ? "day" : "days"} ago";
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return "$weeks ${weeks == 1 ? "week" : "weeks"} ago";
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return "$months ${months == 1 ? "month" : "months"} ago";
    } else {
      int years = (difference.inDays / 365).floor();
      return "$years ${years == 1 ? "year" : "years"} ago";
    }
  }

  ////....... for Ranges .......////
  /// Date Ranges (Yesterday, Today, Tomorrow, Last 7 Days, etc.)
  /// Easy access to common date ranges for filtering data.
  /// Example: bool isToday = IntlDateHelper.isToday(DateTime.now());
  /// Checks if the date matches the given DateRangeType
  /// Supports: today, yesterday, tomorrow, thisWeek, last7Days, leapYear,
  /// thisMonth, lastMonth, nextMonth, thisYear, lastYear, nextYear
  bool isDateRange(DateRangeType type) {
    final date = this;
    DateTime now = DateTime.now();
    switch (type) {
      case DateRangeType.today:
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      case DateRangeType.yesterday:
        DateTime yesterday = now.subtract(Duration(days: 1));
        return date.year == yesterday.year &&
            date.month == yesterday.month &&
            date.day == yesterday.day;
      case DateRangeType.tomorrow:
        DateTime tomorrow = now.add(Duration(days: 1));
        return date.year == tomorrow.year &&
            date.month == tomorrow.month &&
            date.day == tomorrow.day;
      case DateRangeType.thisWeek:
        DateTime startOfWeek =
            DateTime(now.year, now.month, now.day - now.weekday);
        DateTime endOfWeek =
            DateTime(now.year, now.month, now.day + (7 - now.weekday));
        return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
      case DateRangeType.last7Days:
        DateTime last7Days = now.subtract(Duration(days: 7));
        return date.isAfter(last7Days) && date.isBefore(now);
      case DateRangeType.leapYear:
        final year = date.year;
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
      case DateRangeType.thisMonth:
        return date.year == now.year && date.month == now.month;
      case DateRangeType.lastMonth:
        DateTime lastMonth = DateTime(now.year, now.month - 1);
        return date.year == lastMonth.year && date.month == lastMonth.month;
      case DateRangeType.nextMonth:
        DateTime nextMonth = DateTime(now.year, now.month + 1);
        return date.year == nextMonth.year && date.month == nextMonth.month;
      case DateRangeType.thisYear:
        return date.year == now.year;
      case DateRangeType.lastYear:
        return date.year == now.year - 1;
      case DateRangeType.nextYear:
        return date.year == now.year + 1;
    }
  }

  // Deprecated: Use isDateRange(DateRangeType.today) instead
  bool isToday() => isDateRange(DateRangeType.today);
  bool isYesterday() => isDateRange(DateRangeType.yesterday);
  bool isTomorrow() => isDateRange(DateRangeType.tomorrow);
  bool isThisWeek() => isDateRange(DateRangeType.thisWeek);
  bool isLast7Days() => isDateRange(DateRangeType.last7Days);
  bool isLeapYear() => isDateRange(DateRangeType.leapYear);
  // get stat of the week
  DateTime startOfWeek() {
    final date = this;
    return DateTime(date.year, date.month, date.day - date.weekday);
  }

  DateTime endOfWeek() {
    final date = this;
    return DateTime(date.year, date.month, date.day + (7 - date.weekday));
  }
  ////....... END .......////
}
