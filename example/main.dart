// ignore_for_file: avoid_print

import 'package:intl_date_helper/enums/date_range_type.dart';
import 'package:intl_date_helper/extensions/extension_date_helper.dart';
import 'package:intl_date_helper/intl_date_helper.dart';

void main() {
  // Example date string in ISO format
  String isoDate = "2025-03-01T12:30:00.000Z";

  // Formatting a date to a specific format
  String? formattedDate = IntlDateHelper.convertDateFormat(
    dateString: isoDate,
    inputFormat: "yyyy-MM-ddTHH:mm:ssZ",
    outputFormat: "yyyy-MM-dd HH:mm:ss",
  );
  print("Formatted Date: $formattedDate");

  // Parsing a date string into a DateTime object
  DateTime parsedDate = IntlDateHelper.parseDate(
    "01-03-2025 12:30",
    inputFormat: "dd-MM-yyyy HH:mm",
  );
  print("Parsed Date: $parsedDate");

  // Formatting a timestamp (milliseconds since epoch)
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  String formattedTimestamp = IntlDateHelper.formatTimestamp(
    timestamp,
    outputFormat: "EEEE, MMM d, yyyy",
  );
  print("Formatted Timestamp: $formattedTimestamp");

  // Converting a date format
  String newDateFormat = IntlDateHelper.convertDateFormat(
    dateString: "01-03-2025",
    inputFormat: "dd-MM-yyyy",
    outputFormat: "MMMM d, yyyy",
  );
  print("Converted Date Format: $newDateFormat");

  // Converting to UTC format
  String utcDate = IntlDateHelper.toUTC(DateTime.now(),
      outputFormat: "yyyy-MM-dd HH:mm:ss 'UTC'");
  print("UTC Date: $utcDate");

  // Converting to local time
  String localDate = IntlDateHelper.toLocal(DateTime.now(),
      outputFormat: "yyyy-MM-dd HH:mm:ss");
  print("Local Date: $localDate");

  // Converting to a different timezone
  String newYorkTime = IntlDateHelper.convertTimeZone(
    DateTime.now(),
    targetTimeZone: "America/New_York",
    outputFormat: "yyyy-MM-dd HH:mm:ss",
  );
  print("New York Time: $newYorkTime");

  // Getting UTC offset for a specific timezone
  String utcOffset =
      IntlDateHelper.getUTCOffset(DateTime.now(), timeZone: "America/New_York");
  print("UTC Offset: $utcOffset");

  //// Bussiness Dates ////
  final DateTime startDate = DateTime.now();
  final DateTime endDate = DateTime.now().add(Duration(days: 10));

  /// Total business days between two dates
  print("Total business days: ${IntlDateHelper.totalbusinessDaysBetweenDates(
    startDate: startDate,
    endDate: endDate,
  )}");

  /// Get List of business days between two dates
  print("Business days list: ${IntlDateHelper.getBusinessDaysBetweenDates(
    startDate: startDate,
    endDate: endDate,
  )}");

  //// Additional Examples using Extensions ////
  // Getting a relative time with string
  String relativeTime =
      isoDate.parseDate('yyyy-MM-ddTHH:mm:ssZ')!.relativeTime();
  print("Relative Time: $relativeTime");

  /// isToday, isYesterday, isTomorrow, isLast7Days, isThisWeek
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(Duration(days: 1));
  DateTime tomorrow = now.add(Duration(days: 1));
  DateTime last7Days = now.subtract(Duration(days: 7));
  DateTime isThisWeek = now.add(Duration(days: 3));
  DateTime leapYear = DateTime(2024, 2, 29);

  print("Is today: ${now.isToday()}"); // true
  print("Is yesterday: ${yesterday.isYesterday()}"); // true
  print("Is tomorrow: ${tomorrow.isTomorrow()}"); // true
  print("Is last7Days: ${last7Days.isLast7Days()}"); // false
  print("Is this week: ${isThisWeek.isThisWeek()}"); // true
  print("Is leap year: ${leapYear.isLeapYear()}"); // true
  print("startOfWeek: ${now.startOfWeek()}"); // 2025-02-24 00:00:00.000
  print("endOfWeek: ${now.endOfWeek()}"); // 2025-03-02 23:59:59.999

  // --- Custom Date Range Checks ---
  print("Is this month: ${now.isDateRange(DateRangeType.thisMonth)}");
  print("Is last month: ${now.isDateRange(DateRangeType.lastMonth)}");
  print("Is next month: ${now.isDateRange(DateRangeType.nextMonth)}");
  print("Is this year: ${now.isDateRange(DateRangeType.thisYear)}");
  print("Is last year: ${now.isDateRange(DateRangeType.lastYear)}");
  print("Is next year: ${now.isDateRange(DateRangeType.nextYear)}");
}
