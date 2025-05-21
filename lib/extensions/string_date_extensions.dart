import 'package:intl/intl.dart';
import 'package:intl_date_helper/extensions/extension_date_helper.dart';

extension IntlDateHelperStringExtension on String {
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
