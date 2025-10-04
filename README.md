# intl_date_helper

A small, focused Dart/Flutter utility for date parsing, formatting and timezone-aware conversions.

---

## 🌟🌟 New Features 
### 📅 Business Dates
- **Total Business Days Calculation** – Calculate the total number of business days between two dates. 📆
- **Business Days List** – Retrieve a list of business days between two dates. 📋

### 🔄 Additional Extensions
- **Relative Time** – Get a relative time string from a date. ⏳
- **Date Checks** – Check if a date is today, yesterday, tomorrow, within the last 7 days, this week, or a leap year. 📅

## 🌟 Features
✅ **Effortless Date Formatting** – Convert **any** date format easily. 🗓️  
✅ **Timezone Support** – Seamlessly handle multiple time zones using the `timezone` package. 🌍  
✅ **UTC & Local Time Conversions** – Switch between UTC and local time with ease. 🔄  
✅ **Timestamps Made Simple** – Format timestamps without hassle. ⏳  

---

## Installation

Add this to your `pubspec.yaml` (update to the latest version on pub.dev as needed):

```yaml
dependencies:
  intl_date_helper: ^0.2.0
```

Then run:

```bash
flutter pub get
```

---

## 📌 Usage

```dart
import 'package:intl_date_helper/intl_date_helper.dart';

void main() {
  String formattedDate = IntlDateHelper.formatDate("2025-03-01T12:30:00Z", outputFormat: "yyyy-MM-dd HH:mm:ss");
  print("Formatted Date: \$formattedDate");
}
```

For more examples, check out the **[Example Tab](https://pub.dev/packages/intl_date_helper/example)**. 📖

---

## 👤 Author

**Faiz Hassan**  
💻 GitHub: [@faizts](https://github.com/faizts)  
📧 Email: [faizhassan.off@gmail.com](mailto:faizhassan.off@gmail.com)

---

## ⭐ Like this package?
Give it a ⭐ on [pub.dev](https://pub.dev/packages/intl_date_helper) to show your support! 🙌

