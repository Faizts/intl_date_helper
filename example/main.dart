import 'package:intl_date_helper/extension_date_helper.dart';
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

  // Getting a relative time string
  String relativeTime =
      isoDate.parseDate('yyyy-MM-ddTHH:mm:ssZ')!.relativeTime();
  print("Relative Time: $relativeTime");
}
