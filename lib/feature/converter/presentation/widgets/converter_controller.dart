import 'package:flutter/material.dart';
import 'package:lirati/core/enums/currency_type.dart';
import '../blocs/currency/currency_bloc.dart';

class ConverterController {
  final CurrencyBloc currencyBloc;

  ConverterController(this.currencyBloc);

  final ValueNotifier<double> sypAmountNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> convertedAmountNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> rateNotifier = ValueNotifier(0.0);
  final ValueNotifier<String> selectedCurrencyNotifier = ValueNotifier('USD');
  final ValueNotifier<bool> showApiPricesNotifier = ValueNotifier(true);

  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  final Map<String, String> labelKeys = {
    'USD': 'usd_exchange_rate',
    'EUR': 'eur_exchange_rate',
    'TRY': 'try_exchange_rate',
  };

  void calculate() {
    final amountText = amountController.text.replaceAll(',', '');
    final amount = double.tryParse(amountText) ?? 0;
    final rate = rateNotifier.value;

    sypAmountNotifier.value = amount;
    convertedAmountNotifier.value = rate > 0 ? amount / rate : 0;
  }

  Future<void> refreshData() async {
    if (selectedCurrencyNotifier.value != 'SYP') {
      fetchRate(selectedCurrencyNotifier.value);
    }
  }

  void onCurrencyChanged(String slug) {
    if (slug == 'SYP') return;
    selectedCurrencyNotifier.value = slug;
    fetchRate(slug);
  }

  void fetchRate(String slug) {
    currencyBloc.add(GetRateEvent(_slugToCurrencyType(slug)));
  }

  CurrencyType _slugToCurrencyType(String slug) {
    switch (slug) {
      case 'EUR':
        return CurrencyType.euro;
      case 'TRY':
        return CurrencyType.turkey;
      default:
        return CurrencyType.usd;
    }
  }

  void dispose() {
    sypAmountNotifier.dispose();
    convertedAmountNotifier.dispose();
    rateNotifier.dispose();
    selectedCurrencyNotifier.dispose();
    showApiPricesNotifier.dispose();
    amountController.dispose();
    rateController.dispose();
  }
}
