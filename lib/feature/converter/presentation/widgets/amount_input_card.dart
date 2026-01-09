import 'dart:ui' as flutter;

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lirati/core/widgets/thousands_formatter.dart';

class AmountInputCard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCalc;
  final String hint;

  const AmountInputCard({
    super.key,
    required this.controller,
    required this.onCalc,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'enter_old_amount'.tr(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: controller,
              onChanged: (_) => onCalc(),
              onTap: () {
                controller.selection = TextSelection.collapsed(offset: 0);
              },
              textAlign: TextAlign.center,
              textDirection: flutter.TextDirection.ltr,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [ThousandsFormatter(maxDigits: 12)],
              decoration: InputDecoration(
                alignLabelWithHint: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                prefixText: "${'currency_unit'.tr()}  ",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
