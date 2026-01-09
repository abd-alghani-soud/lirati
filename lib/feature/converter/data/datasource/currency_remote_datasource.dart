import 'package:lirati/feature/converter/data/models/currency_rate_model.dart';

abstract class CurrencyRemoteDataSource {
  Future<CurrencyRateModel> getRate(String currencySlug);
}