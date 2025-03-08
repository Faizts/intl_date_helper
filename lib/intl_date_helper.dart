library intl_date_helper;

import 'package:intl/intl.dart';
import 'package:intl_date_helper/utils.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class IntlDateHelper {
  // Static flag to track if we've set up timezones - because time is relative,
  // but initialization should only happen once! ⏳
  static bool _isInitialized = false;

  // Initializes timezone data. Think of it as teaching our app about world timezones.
  // (Calling this multiple times is like explaining timezones to a goldfish 🐠)
  static void _initializeTimeZones() {
    if (!_isInitialized) {
      tz.initializeTimeZones();
      _isInitialized = true;
    }
  }

  /// Formats any date-like object into a pretty string.
  /// [date] - Can be DateTime, int (timestamp), or String (ISO format)
  /// [outputFormat] - The desired date format (e.g., 'yyyy-MM-dd')
  /// [timeZone] - Optional: Target timezone (e.g., 'America/New_York')
  /// Returns: Formatted date string looking fresh in its new outfit 👗
  static String formatDate(dynamic date,
      {required String outputFormat, String? timeZone}) {
    DateTime parsedDate = _convertToDateTime(date);
    if (timeZone != null) {
      parsedDate = _convertToTimeZone(parsedDate, timeZone);
    }
    return DateFormat(outputFormat).format(parsedDate);
  }

  /// Parses a date string with a secret decoder ring (input format) 🔍
  /// [dateString] - The mysterious date string waiting to be understood
  /// [inputFormat] - The Rosetta Stone to decipher the date string
  /// Returns: DateTime object feeling validated and understood 🧩
  static DateTime parseDate(String dateString, {String? inputFormat}) {
    return _parseDateString(dateString, inputFormat);
  }

  /// Turns a shy timestamp into a beautifully formatted string
  /// [timestamp] - The number of milliseconds since the epoch (Jan 1, 1970)
  /// [outputFormat] - The makeover plan for our timestamp 💅
  /// [timeZone] - Optional: Timezone destination for our timestamp's vacation 🌴
  static String formatTimestamp(int timestamp,
      {required String outputFormat, String? timeZone}) {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(timestamp),
        outputFormat: outputFormat, timeZone: timeZone);
  }

  /// Transforms date strings between formats like a fashion stylist 👗
  /// [dateString] - The original date outfit
  /// [inputFormat] - What the current outfit looks like
  /// [outputFormat] - The fabulous new look we want
  /// [timeZone] - Optional: Timezone catwalk for the big reveal 💃
  /// Returns: Date string ready for the red carpet (or error message if fashion disaster occurs)
  static String convertDateFormat({
    required String dateString,
    String? inputFormat,
    required String outputFormat,
    String? timeZone,
  }) {
    try {
      DateTime parsedDate = _parseDateString(dateString, inputFormat);
      if (timeZone != null) {
        parsedDate = _convertToTimeZone(parsedDate, timeZone);
      }
      return DateFormat(outputFormat).format(parsedDate);
    } catch (e) {
      return 'Invalid date or format';
    }
  }

  /// Teleports local time to UTC coordinates 🚀
  /// [date] - The time traveler
  /// [outputFormat] - The postcard format from UTC land
  static String toUTC(dynamic date, {required String outputFormat}) {
    return DateFormat(outputFormat).format(_convertToUTC(date));
  }

  /// Brings UTC time back home to local time 🏡
  /// [date] - The world traveler
  /// [outputFormat] - The local time's "what I did on my vacation" presentation
  static String toLocal(dynamic date, {required String outputFormat}) {
    return DateFormat(outputFormat).format(_convertToDateTime(date).toLocal());
  }

  /// Gives a date a new timezone passport 🌍
  /// [date] - The jet-setting date
  /// [targetTimeZone] - The destination timezone
  /// [outputFormat] - The souvenir format from the trip
  /// Returns: Date in the new timezone
  static String convertTimeZone(dynamic date,
      {required String targetTimeZone, required String outputFormat}) {
    DateTime parsedDate = _convertToDateTime(date);
    parsedDate = _convertToTimeZone(parsedDate, targetTimeZone);
    return DateFormat(outputFormat).format(parsedDate);
  }

  /// Reveals a timezone's UTC offset like a watch inspector ⌚
  /// [date] - The moment in time to check
  /// [timeZone] - The timezone neighborhood to investigate
  /// Returns: UTC offset in ±HH:mm format (because timezones love drama)
  static String getUTCOffset(dynamic date, {required String timeZone}) {
    DateTime parsedDate = _convertToDateTime(date);
    tz.Location location = tz.getLocation(timeZone);
    tz.TZDateTime converted = tz.TZDateTime.from(parsedDate, location);
    return _formatUTCOffset(converted.timeZoneOffset);
  }

  /// The Great Date Detective 🔍 (Handles all date-like objects)
  /// [date] - Could be DateTime, timestamp (int), or ISO string
  /// Returns: Unified DateTime object
  /// Throws: FormatException if it encounters an alien date format 👽
  static DateTime _convertToDateTime(dynamic date) {
    if (date is DateTime) return date;
    if (date is int) return DateTime.fromMillisecondsSinceEpoch(date);
    if (date is String) return _parseDateString(date);
    throw FormatException('Unsupported date format');
  }

  static DateTime _convertToUTC(dynamic date) {
    DateTime parsedDate = _convertToDateTime(date);
    return parsedDate.toUtc();
  }

  /// Timezone Taxi Service 🚖 (Moves dates between timezones)
  /// [date] - The passenger date
  /// [timeZone] - The destination district
  /// Returns: Date safely delivered to new timezone
  static DateTime _convertToTimeZone(DateTime date, String timeZone) {
    _initializeTimeZones();
    tz.Location location = tz.getLocation(timeZone);
    return tz.TZDateTime.from(date, location);
  }


  static DateTime _parseDateString(String date, [String? format]) {
    if (_isISO8601UTC(date)) return DateTime.parse(date).toUtc();

    List<String> formats = HelperUtils.supportedFormatedDates;

    if (format != null) {
      try {
        return DateFormat(format).parseStrict(date);
      } catch (_) {}
    }

    for (var format in formats) {
      try {
        return DateFormat(format).parseStrict(date);
      } catch (_) {}
    }
    throw FormatException('Invalid date string: $date');
  }

  static bool _isISO8601UTC(String date) {
    return RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?Z\$')
        .hasMatch(date);
  }

  static String _formatUTCOffset(Duration offset) {
    String sign = offset.isNegative ? '-' : '+';
    return '$sign${offset.inHours.abs().toString().padLeft(2, '0')}:${(offset.inMinutes.abs() % 60).toString().padLeft(2, '0')}';
  }
}
