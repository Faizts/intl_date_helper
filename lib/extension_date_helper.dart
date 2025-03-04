import 'package:intl/intl.dart';

import 'intl_date_helper.dart';

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
    DateTime? date = this.parseDate('yyyy-MM-ddTHH:mm:ssZ');
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
}
