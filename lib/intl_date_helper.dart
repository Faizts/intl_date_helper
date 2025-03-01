library intl_date_helper;

import 'package:intl/intl.dart';
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
  static String formatDate(
    dynamic date, {
    required String outputFormat,
    String? timeZone,
  }) {
    DateTime parsedDate = _convertToDateTime(date);

    if (timeZone != null) {
      parsedDate = convertToTimeZone(parsedDate, timeZone);
    }

    return DateFormat(outputFormat).format(parsedDate);
  }

  /// Parses a date string with a secret decoder ring (input format) 🔍
  /// [dateString] - The mysterious date string waiting to be understood
  /// [inputFormat] - The Rosetta Stone to decipher the date string
  /// Returns: DateTime object feeling validated and understood 🧩
  static DateTime parseDate(String dateString, {required String inputFormat}) {
    return DateFormat(inputFormat).parse(dateString);
  }

  /// Turns a shy timestamp into a beautifully formatted string
  /// [timestamp] - The number of milliseconds since the epoch (Jan 1, 1970)
  /// [outputFormat] - The makeover plan for our timestamp 💅
  /// [timeZone] - Optional: Timezone destination for our timestamp's vacation 🌴
  static String formatTimestamp(
    int timestamp, {
    required String outputFormat,
    String? timeZone,
  }) {
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
    required String inputFormat,
    required String outputFormat,
    String? timeZone,
  }) {
    try {
      DateTime parsedDate = DateFormat(inputFormat).parse(dateString);
      if (timeZone != null) {
        parsedDate = convertToTimeZone(parsedDate, timeZone);
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
    DateTime parsedDate = _convertToDateTime(date).toUtc();
    return DateFormat(outputFormat).format(parsedDate);
  }

  /// Brings UTC time back home to local time 🏡
  /// [date] - The world traveler
  /// [outputFormat] - The local time's "what I did on my vacation" presentation
  static String toLocal(dynamic date, {required String outputFormat}) {
    DateTime parsedDate = _convertToDateTime(date).toLocal();
    return DateFormat(outputFormat).format(parsedDate);
  }

  /// Gives a date a new timezone passport 🌍
  /// [date] - The jet-setting date
  /// [targetTimeZone] - The destination timezone
  /// [outputFormat] - The souvenir format from the trip
  /// Returns: Date in the new timezone
  static String convertTimeZone(
    dynamic date, {
    required String targetTimeZone,
    required String outputFormat,
  }) {
    DateTime parsedDate = _convertToDateTime(date);
    parsedDate = convertToTimeZone(parsedDate, targetTimeZone);
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
    Duration offset = converted.timeZoneOffset;
    return _formatUTCOffset(offset);
  }

  /// The Great Date Detective 🔍 (Handles all date-like objects)
  /// [date] - Could be DateTime, timestamp (int), or ISO string
  /// Returns: Unified DateTime object
  /// Throws: FormatException if it encounters an alien date format 👽
  static DateTime _convertToDateTime(dynamic date) {
    if (date is DateTime) {
      return date;
    } else if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date);
    } else if (date is String) {
      try {
        return DateTime.parse(date);
      } catch (e) {
        throw FormatException('Invalid date string: $date');
      }
    } else {
      throw FormatException('Unsupported date format');
    }
  }

  /// Timezone Taxi Service 🚖 (Moves dates between timezones)
  /// [date] - The passenger date
  /// [timeZone] - The destination district
  /// Returns: Date safely delivered to new timezone
  static DateTime convertToTimeZone(DateTime date, String timeZone) {
    _initializeTimeZones();
    tz.Location location = tz.getLocation(timeZone);
    return tz.TZDateTime.from(date, location);
  }

  /// Creates a friendly UTC offset string 😊
  /// [offset] - The duration to format
  /// Returns: ±HH:mm string (always wears matching hour/minute outfits)
  static String _formatUTCOffset(Duration offset) {
    String sign = offset.isNegative ? '-' : '+';
    int hours = offset.inHours.abs();
    int minutes = (offset.inMinutes.abs()) % 60;
    return '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}
