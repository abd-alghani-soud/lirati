import '../../domain/entities/currency_rate.dart';

class CurrencyRateModel extends CurrencyRate {
  const CurrencyRateModel({
    required super.buyPrice,
    required super.sellPrice,
    required super.currencyName,
  });

  factory CurrencyRateModel.fromRawHtml(String html, String currencySlug) {
    double toDouble(String raw) {
      try {
        return double.parse(
          raw.replaceAll(',', '').replaceAll(RegExp(r'[^\d.]'), ''),
        );
      } catch (_) {
        return 0.0;
      }
    }

    double buy = 0.0;
    double sell = 0.0;
    final buyRegex = RegExp(
      r'شراء[^0-9]{0,50}(\d{1,3}(?:,\d{3})+)',
      unicode: true,
    );
    final sellRegex = RegExp(
      r'بيع[^0-9]{0,50}(\d{1,3}(?:,\d{3})+)',
      unicode: true,
    );
    final buyMatch = buyRegex.firstMatch(html);
    final sellMatch = sellRegex.firstMatch(html);
    if (buyMatch != null) buy = toDouble(buyMatch.group(1)!);
    if (sellMatch != null) sell = toDouble(sellMatch.group(1)!);
    if (buy == 0.0 || sell == 0.0) {
      final numbers = RegExp(
        r'\d{1,3}(?:,\d{3})+',
      ).allMatches(html).map((e) => toDouble(e.group(0)!)).toList();
      if (numbers.isNotEmpty) {
        buy = numbers.first;
        sell = numbers.length > 1 ? numbers[1] : numbers.first;
      }
    }
    if (currencySlug == 'TRY' ||
        currencySlug.contains('turkey') ||
        currencySlug.contains('ليرة')) {
      if (buy > 1000) {
        buy = buy / 10;
      }
      if (sell > 1000) {
        sell = sell / 10;
      }
    }
    if (currencySlug == 'TRY' ||
        currencySlug.contains('turkish-lira') ||
        currencySlug.contains('ليرة')) {
      return CurrencyRateModel(
        buyPrice: buy / 10,
        sellPrice: sell / 10,
        currencyName: currencySlug,
      );
    }
    return CurrencyRateModel(
      buyPrice: buy,
      sellPrice: sell,
      currencyName: currencySlug,
    );
  }
}
