import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_controller.dart';
import 'rate_input_card.dart';
import 'amount_input_card.dart';

class ConverterInputsSection extends StatelessWidget {
  final ConverterController controller;
  final GlobalKey? amountKey;

  const ConverterInputsSection({
    super.key,
    required this.controller,
    this.amountKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<String>(
          valueListenable: controller.selectedCurrencyNotifier,
          builder: (context, currency, widget) {
            final labelKey =
                controller.labelKeys[currency] ?? controller.labelKeys['USD']!;
            return RateInputCard(
              controller: controller.rateController,
              notifier: controller.rateNotifier,
              onCalc: controller.calculate,
              label: labelKey.tr(),
              hintText: 'enter_rate_manually'.tr(),
            );
          },
        ),
        SizedBox(height: 12.h),
        Container(
          key: amountKey,
          child: AmountInputCard(
            controller: controller.amountController,
            onCalc: controller.calculate,
            hint: 'enter_amount_in_syp'.tr(),
          ),
        ),
      ],
    );
  }
}
