import 'package:test/test.dart';
import 'package:intl_date_helper/intl_date_helper.dart';

void main() {
  group('IntlDateHelper Tests', () {
    test('Format date correctly', () {
      // DateTime date = DateTime(2025, 3, 1, 14, 30);
      String date = '2025/03/01';
      String? formattedDate =
          IntlDateHelper.formatDate(date, outputFormat: 'yyyy-MM-dd HH:mm');

      expect(formattedDate, '2025-03-01 14:30');
    });

    test('Parse date from custom format', () {
      String inputDate = '01-03-2025 02:30 PM';
      DateTime parsedDate = IntlDateHelper.parseDate(inputDate,
          inputFormat: 'dd-MM-yyyy hh:mm a');

      expect(parsedDate.year, 2025);
      expect(parsedDate.month, 3);
      expect(parsedDate.day, 1);
      expect(parsedDate.hour, 14);
      expect(parsedDate.minute, 30);
    });

    test('Convert timezone', () {
      DateTime utcDate = DateTime.utc(2025, 3, 1, 14, 30);
      String convertedDate = IntlDateHelper.convertTimeZone(utcDate,
          targetTimeZone: 'America/New_York',
          outputFormat: 'yyyy-MM-dd HH:mm:ss');

      expect(
          convertedDate, '2025-03-01 09:30:00'); // Adjust for daylight savings
    });

    test('Convert date format', () {
      String newDateFormat = IntlDateHelper.convertDateFormat(
        dateString: "01/03/2025",
        inputFormat: "MMM/dd/yyyy",
        outputFormat: 'MMMM d, yyyy',
      );

      expect(newDateFormat, 'March 1, 2025');
    });
  });
}
