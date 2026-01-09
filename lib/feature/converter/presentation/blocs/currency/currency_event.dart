part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class GetRateEvent extends CurrencyEvent {
  final CurrencyType currencyType;

  const GetRateEvent(this.currencyType);
}
