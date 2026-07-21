import 'package:intl/intl.dart';

class CurrencyHelper {
  static String format(double number) {
    final nf = NumberFormat.simpleCurrency(locale: 'pt_BR', decimalDigits: 2);
    return nf.format(number);
  }
}
