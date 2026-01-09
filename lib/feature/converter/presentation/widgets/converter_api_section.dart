import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_controller.dart';
import 'currency_selector.dart';
import 'api_rates_card.dart';

class ConverterApiSection extends StatelessWidget {
  final ConverterController controller;

  const ConverterApiSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<String>(
          valueListenable: controller.selectedCurrencyNotifier,
          builder: (context, selected, widget) => CurrencySelector(
            selected: selected,
            onChanged: controller.onCurrencyChanged,
          ),
        ),
        SizedBox(height: 12.h),
        ValueListenableBuilder<bool>(
          valueListenable: controller.showApiPricesNotifier,
          builder: (context, isActivated, widget) {
            if (!isActivated) {
              return SizedBox(
                width: 0.9.sw,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: controller.onPressShowToday,
                  child: Text('today_lira'.tr()),
                ),
              );
            } else {
              return ApiRatesCard(
                visible: true,
                bloc: controller.currencyBloc,
                rateNotifier: controller.rateNotifier,
                rateController: controller.rateController,
                onCalculate: controller.calculate,
              );
            }
          },
        ),
      ],
    );
  }
}
