import 'package:test/test.dart';
import 'package:intl_date_helper/intl_date_helper.dart';

void main() {
  group('IntlDateHelper Tests', () {
    test('Format date correctly', () {
      DateTime date = DateTime(2025, 3, 1, 14, 30);
      String formattedDate = IntlDateHelper.formatDate(date, outputFormat: 'yyyy-MM-dd HH:mm');

      expect(formattedDate, '2025-03-01 14:30');
    });

    test('Parse date from custom format', () {
      String inputDate = '01-03-2025 02:30 PM';
      DateTime parsedDate = IntlDateHelper.parseDate(inputDate, inputFormat: 'dd-MM-yyyy hh:mm a');

      expect(parsedDate.year, 2025);
      expect(parsedDate.month, 3);
      expect(parsedDate.day, 1);
      expect(parsedDate.hour, 14);
      expect(parsedDate.minute, 30);
    });

    test('Convert timezone', () {
      DateTime utcDate = DateTime.utc(2025, 3, 1, 14, 30);
      DateTime convertedDate = IntlDateHelper.convertToTimeZone(utcDate, 'America/New_York');

      expect(convertedDate.timeZoneName, 'EST'); // Adjust for daylight savings
    });
  });
}
