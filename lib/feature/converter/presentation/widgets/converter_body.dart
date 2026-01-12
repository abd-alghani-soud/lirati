import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_api_section.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_controller.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_inputs_section.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_results_section.dart';

class ConverterBody extends StatelessWidget {
  final ConverterController controller;
  final GlobalKey? amountKey;
  final GlobalKey? resultKey;
  final GlobalKey? rateKey;

  const ConverterBody({
    super.key,
    required this.controller,
    this.amountKey,
    this.resultKey,
    this.rateKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
      child: Column(
        children: [
          ConverterInputsSection(
            controller: controller,
            amountKey: amountKey,
            rateKey: rateKey,
          ),
          SizedBox(height: 16.h),
          ConverterResultsSection(controller: controller, resultKey: resultKey),
          SizedBox(height: 20.h),
          ConverterApiSection(controller: controller),
        ],
      ),
    );
  }
}
