import 'package:flutter/material.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_controller.dart';
import 'results_row.dart';

class ConverterResultsSection extends StatelessWidget {
  final ConverterController controller;
  final GlobalKey? resultKey;

  const ConverterResultsSection({
    super.key,
    required this.controller,
    this.resultKey,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: controller.selectedCurrencyNotifier,
      builder: (context, currency, widget) {
        return Container(
          key: resultKey,
          child: ResultsRow(
            newAmountNotifier: controller.sypAmountNotifier,
            currencyAmountNotifier: controller.convertedAmountNotifier,
            currencySymbol: currency == 'USD'
                ? '\$'
                : currency == 'EUR'
                ? '€'
                : 'ليرة',
            currencyLabelKey: currency == 'USD'
                ? 'approx_usd'
                : currency == 'EUR'
                ? 'approx_eur'
                : 'approx_try',
          ),
        );
      },
    );
  }
}
