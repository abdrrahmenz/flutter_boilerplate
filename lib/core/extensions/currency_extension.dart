import 'package:intl/intl.dart';

extension CurrencyFormat on num {
  String toIDR() {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'IDR ',
      decimalDigits: 0,
    );
    return formatCurrency.format(this);
  }
}
