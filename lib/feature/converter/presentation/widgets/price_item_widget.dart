import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceItemWidget extends StatelessWidget {
  final String label;
  final double price;
  final Color color;
  final IconData icon;
  final bool isDark;

  const PriceItemWidget({
    super.key,
    required this.label,
    required this.price,
    required this.color,
    required this.icon,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isDark ? color.withOpacity(0.1) : color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: color.withOpacity(isDark ? 0.3 : 0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.w),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              '${price.toStringAsFixed(0)} ${'currency_unit'.tr()}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
