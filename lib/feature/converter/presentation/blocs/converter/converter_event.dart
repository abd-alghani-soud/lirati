part of 'converter_bloc.dart';

abstract class ConverterEvent {}

class LoadRatesEvent extends ConverterEvent {}

class UpdateRateEvent extends ConverterEvent {
  final double rate;

  UpdateRateEvent(this.rate);
}
