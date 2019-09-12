import 'package:intl/intl.dart';

class Formatter {
  static String numericOnly(String value) {
    return value.replaceAll(new RegExp(r'(?:^|\D)'), '');
  }

  static String toCurrency(double value, String locale) {
    if (value == null) return "0";
    return new NumberFormat("#,##0.00", locale).format(value);
  }

  //TODO
  static String moneyFormatter(double value) {
    //TODO
    var signal = value < 0 ? "- R\$ " : "R\$ ";

    return signal + Formatter.toCurrency(value, Intl.defaultLocale);
  }
}
