import 'package:intl/intl.dart';
String FormatCurrency( num value) {
  final formatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
    decimalDigits: 0,
  );
  return formatter.format(value);
}