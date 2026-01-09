import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lirati/core/constants/my_color.dart';
import 'package:lirati/core/constants/my_images.dart';

class ConverterSliverAppBar extends StatelessWidget {
  final GlobalKey? menuKey;

  const ConverterSliverAppBar({super.key, this.menuKey});

  @override
  Widget build(BuildContext context) {
    final double expandedHeight = 150.h;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return SliverAppBar(
      backgroundColor: MyColor.primaryColor,
      expandedHeight: expandedHeight,
      pinned: true,
      elevation: 0,
      leading: Builder(
        builder: (ctx) => Container(
          key: menuKey,
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 24.w),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double currentHeight = constraints.biggest.height;
          final bool isCollapsed =
              currentHeight <= kToolbarHeight + statusBarHeight + 5.h;

          return FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.zero,
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: isCollapsed
                  ? _CollapsedTitle(key: const ValueKey('collapsed'))
                  : const SizedBox.shrink(),
            ),
            background: isCollapsed
                ? const SizedBox.shrink()
                : _ExpandedTitle(),
            collapseMode: CollapseMode.pin,
          );
        },
      ),
    );
  }
}

class _CollapsedTitle extends StatelessWidget {
  _CollapsedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(MyImages.logoSyria, height: 20.h),
          SizedBox(width: 8.w),
          Text(
            'app_name'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandedTitle extends StatelessWidget {
  _ExpandedTitle();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(MyImages.logoSyria, height: 45.h),
          SizedBox(width: 15.w),
          Text(
            'app_name'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
