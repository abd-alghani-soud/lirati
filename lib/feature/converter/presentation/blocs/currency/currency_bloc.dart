import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lirati/core/enums/currency_type.dart';
import 'package:lirati/core/utils/request_status.dart';
import 'package:lirati/feature/converter/domain/entities/currency_rate.dart';
import 'package:lirati/feature/converter/domain/usecases/get_currency_rate_usecase.dart';

part 'currency_event.dart';

part 'currency_state.dart';

@lazySingleton
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrencyRateUsecase _getCurrencyRateUseCase;

  CurrencyBloc(this._getCurrencyRateUseCase) : super(const CurrencyState()) {
    on<GetRateEvent>((event, emit) async {
      emit(
        state.copyWith(
          getCurrencyState: RequestStatus.loading,
          currencyType: event.currencyType,
          messageError: '',
        ),
      );

      final result = await _getCurrencyRateUseCase(event.currencyType.slug);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              getCurrencyState: RequestStatus.failed,
              messageError: failure.message,
            ),
          );
        },
        (rate) {
          emit(
            state.copyWith(
              getCurrencyState: RequestStatus.success,
              rate: rate,
              messageError: '',
            ),
          );
        },
      );
    });
  }
}
