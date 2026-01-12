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
  final CurrencyBloc bloc;
  final ValueNotifier<double> rateNotifier;
  final TextEditingController rateController;
  final VoidCallback onCalculate;
  final VoidCallback? onRefresh;

  const ApiRatesCard({
    super.key,
    required this.bloc,
    required this.rateNotifier,
    required this.rateController,
    required this.onCalculate,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
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
        bool isLoading = state.getCurrencyState == RequestStatus.loading;

        return InkWell(
          onTap: onRefresh,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.grey[50],
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.autorenew, size: 16.w, color: Colors.grey),
                        SizedBox(width: 6.w),
                        Text(
                          'live_rates'.tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (isLoading)
                      SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    else if (onRefresh != null)
                      IconButton(
                        icon: Icon(Icons.refresh, size: 20.w),
                        color: Colors.grey,
                        onPressed: onRefresh,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                  ],
                ),
                SizedBox(height: 12.h),

                if (state.getCurrencyState == RequestStatus.loading) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: LoadingWidget(),
                  ),
                ] else if (state.getCurrencyState == RequestStatus.failed) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Column(
                      children: [
                        ErrorMessageWidget(messageError: state.messageError),
                        SizedBox(height: 16.h),
                        if (onRefresh != null)
                          ElevatedButton.icon(
                            onPressed: onRefresh,
                            icon: Icon(Icons.refresh),
                            label: Text('retry'.tr()),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 40.h),
                            ),
                          ),
                      ],
                    ),
                  ),
                ] else if (state.getCurrencyState == RequestStatus.success) ...[
                  Row(
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
                  SizedBox(height: 8.h),
                  Text(
                    'tap_to_refresh'.tr(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Column(
                      children: [
                        Icon(Icons.downloading, size: 32.w, color: Colors.grey),
                        SizedBox(height: 8.h),
                        Text(
                          'loading_rates'.tr(),
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
