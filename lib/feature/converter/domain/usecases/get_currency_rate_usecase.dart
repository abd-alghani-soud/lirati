import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:lirati/feature/converter/domain/repository/currency_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/currency_rate.dart';

@injectable
class GetCurrencyRateUsecase {
  final CurrencyRepository repository;

  GetCurrencyRateUsecase(this.repository);

  Future<Either<Failure, CurrencyRate>> call(String currencySlug) async {
    return await repository.getCurrencyRate(currencySlug);
  }
}
