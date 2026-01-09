import 'package:dartz/dartz.dart';
import '../entities/currency_rate.dart';
import '../../../../core/error/failures.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, CurrencyRate>> getCurrencyRate(String currencySlug);
}
