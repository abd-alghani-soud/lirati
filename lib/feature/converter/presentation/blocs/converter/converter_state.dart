part of 'converter_bloc.dart';

abstract class ConverterState {}

class ConverterLoading extends ConverterState {}

class ConverterLoaded extends ConverterState {
  final double rate;

  ConverterLoaded(this.rate);
}
