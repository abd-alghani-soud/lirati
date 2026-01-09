import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateInputCard extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<double> notifier;
  final VoidCallback onCalc;
  final String label;
  final String hintText;

  const RateInputCard({
    super.key,
    required this.controller,
    required this.notifier,
    required this.onCalc,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, size: 24.w),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 155.w,
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      notifier.value =
                          double.tryParse(val.replaceAll(',', '')) ?? 0;
                      onCalc();
                    },
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            Row(
              children: [
                Icon(Icons.info_outline, size: 16.w, color: Colors.red),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    "check_rate_warning".tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
