import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'result_item.dart';

class ResultsRow extends StatelessWidget {
  final ValueNotifier<double> newAmountNotifier;
  final ValueNotifier<double> currencyAmountNotifier;
  final String currencySymbol;
  final String currencyLabelKey;

  const ResultsRow({
    super.key,
    required this.newAmountNotifier,
    required this.currencyAmountNotifier,
    required this.currencySymbol,
    required this.currencyLabelKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder<double>(
          valueListenable: newAmountNotifier,
          builder: (context, val, _) => ResultItem(
            label: 'current_amount',
            value: NumberFormat("#,###.##").format(val / 100),
            color: const Color(0xFFE8F5E9),
            textColor: const Color(0xFF064D3B),
          ),
        ),
        SizedBox(width: 12.w),
        ValueListenableBuilder<double>(
          valueListenable: currencyAmountNotifier,
          builder: (context, val, _) => ResultItem(
            label: currencyLabelKey,
            value: "${NumberFormat("#,###.##").format(val)} $currencySymbol",
            color: Colors.blue.shade50.withOpacity(0.6),
            textColor: const Color(0xFF0D47A1),
          ),
        ),
      ],
    );
  }
}
