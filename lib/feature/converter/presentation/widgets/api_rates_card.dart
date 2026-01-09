import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lirati/core/utils/request_status.dart';
import 'package:lirati/core/widgets/error_message_widget.dart';
import 'package:lirati/core/widgets/loading_widget.dart';
import 'package:lirati/feature/converter/presentation/blocs/currency/currency_bloc.dart';
import 'package:lirati/feature/converter/presentation/widgets/price_item_widget.dart';

class ApiRatesCard extends StatelessWidget {
  final bool visible;
  final CurrencyBloc bloc;
  final ValueNotifier<double> rateNotifier;
  final TextEditingController rateController;
  final VoidCallback onCalculate;

  const ApiRatesCard({
    super.key,
    required this.visible,
    required this.bloc,
    required this.rateNotifier,
    required this.rateController,
    required this.onCalculate,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<CurrencyBloc, CurrencyState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.getCurrencyState == RequestStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            rateNotifier.value = state.rate.sellPrice;
            rateController.text = state.rate.sellPrice.toStringAsFixed(0);
            onCalculate();
          });
        }
      },
      builder: (context, state) {
        if (state.getCurrencyState == RequestStatus.loading) {
          return Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: LoadingWidget(),
          );
        }
        if (state.getCurrencyState == RequestStatus.failed) {
          return Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: ErrorMessageWidget(messageError: state.messageError),
          );
        }
        if (state.getCurrencyState == RequestStatus.success) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                PriceItemWidget(
                  label: 'buy_price'.tr(),
                  price: state.rate.buyPrice,
                  color: Colors.green,
                  icon: Icons.arrow_upward,
                  isDark: isDark,
                ),
                SizedBox(width: 12.w),
                PriceItemWidget(
                  label: 'sell_price'.tr(),
                  price: state.rate.sellPrice,
                  color: Colors.red,
                  icon: Icons.arrow_downward,
                  isDark: isDark,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
