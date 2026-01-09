import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'currency_button.dart';

class CurrencySelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const CurrencySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 50.h,
        child: Row(
          children: [
            CurrencyButton(
              label: 'usd_button'.tr(),
              isSelected: selected == 'USD',
              onTap: () => onChanged('USD'),
            ),
            CurrencyButton(
              label: 'eur_button'.tr(),
              isSelected: selected == 'EUR',
              onTap: () => onChanged('EUR'),
            ),
            CurrencyButton(
              label: 'try_button'.tr(),
              isSelected: selected == 'TRY',
              onTap: () => onChanged('TRY'),
            ),
          ],
        ),
      ),
    );
  }
}
