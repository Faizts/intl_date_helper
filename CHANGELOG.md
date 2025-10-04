## 0.1.4
- Added support for custom date range checks: thisMonth, lastMonth, nextMonth, thisYear, lastYear, nextYear via DateRangeType enum and DateTime extension.
- You can now check if a date is in the current, previous, or next month/year using isDateRange(DateRangeType.type).

## 0.1.3
- Added support for calculating total business days between two dates.
- Added functionality to get a list of business days between two dates.
- Added extensions for relative time parsing.
- Added methods to check if a date is today, yesterday, tomorrow, within the last 7 days, this week, or a leap year.
- Added methods to get the start and end of the week.
- Added support for calculating total business days between two dates.
- Added functionality to get a list of business days between two dates.
- Added extensions for relative time parsing.
- Added methods to check if a date is today, yesterday, tomorrow, within the last 7 days, this week, or a leap year.

## 0.1.2
- Added extension for parsing and relative time.

## 0.1.0 - Initial Release
- Added date formatting support.
- Added date parsing functionality.
- Added timezone conversion.

## 0.2.0
- Fix: Correct ISO8601 UTC detection and parsing of Z-suffixed timestamps.
- Fix: Ensure timezone data is initialized before timezone conversions and UTC-offset queries.
- Improvement: Cache timezone `Location` objects to reduce repeated lookups.
- Tests: Adjusted and expanded tests to cover parsing and timezone conversion.