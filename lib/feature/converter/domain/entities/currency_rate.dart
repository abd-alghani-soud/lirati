import 'package:equatable/equatable.dart';

class CurrencyRate extends Equatable {
  final double buyPrice;
  final double sellPrice;
  final String currencyName;

  const CurrencyRate({
    required this.buyPrice,
    required this.sellPrice,
    required this.currencyName,
  });

  @override
  List<Object> get props => [buyPrice, sellPrice, currencyName];
}
