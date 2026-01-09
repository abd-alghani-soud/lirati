part of 'currency_bloc.dart';

class CurrencyState extends Equatable {
  final RequestStatus getCurrencyState;
  final String messageError;
  final CurrencyRate rate;
  final CurrencyType currencyType;

  const CurrencyState({
    this.currencyType = CurrencyType.usd,
    this.rate = const CurrencyRate(buyPrice: 0, sellPrice: 0, currencyName: ''),
    this.messageError = '',
    this.getCurrencyState = RequestStatus.init,
  });

  @override
  List<Object?> get props => [
    getCurrencyState,
    messageError,
    rate,
    currencyType,
  ];

  CurrencyState copyWith({
    RequestStatus? getCurrencyState,
    String? messageError,
    CurrencyRate? rate,
    CurrencyType? currencyType,
  }) {
    return CurrencyState(
      getCurrencyState: getCurrencyState ?? this.getCurrencyState,
      messageError: messageError ?? this.messageError,
      rate: rate ?? this.rate,
      currencyType: currencyType ?? this.currencyType,
    );
  }
}
