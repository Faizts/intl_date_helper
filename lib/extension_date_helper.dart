import 'package:intl/intl.dart';


extension IntlDateHelperExtension on String {
  DateTime? parseDate(String format) {
    try {
      final DateFormat dateFormat = DateFormat(format);
      return dateFormat.parse(this);
    } catch (e) {
      return null;
    }
  }

  /// Relative time string (e.g., "5 minutes ago")
  String relativeTime() {
    DateTime? date = parseDate('yyyy-MM-ddTHH:mm:ssZ');
    if (date == null) {
      return "Invalid date";
    }
    return date.relativeTime();
  }
}

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
  bool isToday() {
    final date = this;
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isYesterday() {
    final date = this;
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  bool isTomorrow() {
    final date = this;
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  bool isThisWeek() {
    final date = this;
    DateTime now = DateTime.now();
    DateTime startOfWeek = DateTime(now.year, now.month, now.day - now.weekday);
    DateTime endOfWeek =
        DateTime(now.year, now.month, now.day + (7 - now.weekday));
    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }

  bool isLast7Days() {
    final date = this;
    DateTime now = DateTime.now();
    DateTime last7Days = now.subtract(Duration(days: 7));
    return date.isAfter(last7Days) && date.isBefore(now);
  }

  bool isLeapYear() {
    final year = this.year;
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

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
