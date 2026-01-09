import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lirati/core/services/shared_preferences_service.dart';

part 'converter_event.dart';

part 'converter_state.dart';

@injectable
class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc() : super(ConverterLoading()) {
    on<LoadRatesEvent>((event, emit) {
      final rate = SharedPreferencesService.getUsdRate();
      emit(ConverterLoaded(rate));
    });

    on<UpdateRateEvent>((event, emit) async {
      await SharedPreferencesService.storeUsdRate(event.rate);
      emit(ConverterLoaded(event.rate));
    });

    add(LoadRatesEvent());
  }
}
