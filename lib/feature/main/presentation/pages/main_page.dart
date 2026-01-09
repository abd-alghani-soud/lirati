import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lirati/core/constants/my_color.dart';
import 'package:lirati/core/constants/my_images.dart';
import 'package:lirati/core/services/dependecies.dart';
import 'package:lirati/feature/main/presentation/pages/about_me_page.dart';
import '../../../../core/cubit/theme_cubit.dart';
import '../../../converter/presentation/page/converter_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, this.startTutorial = false});

  final bool startTutorial;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher.switcher(
      clipper: ThemeSwitcherCircleClipper(),
      builder: (context, switcher) {
        return Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: MyColor.primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(MyImages.logoSyria, height: 50.h),
                      SizedBox(width: 8.w),
                      Text(
                        'logo_name'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: MyColor.primaryColor,
                    size: 24.w,
                  ),
                  title: Text(
                    'language'.tr(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  trailing: DropdownButton<String>(
                    value: context.locale.languageCode,
                    underline: const SizedBox(),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(
                          'english'.tr(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text(
                          'arabic'.tr(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) context.setLocale(Locale(value));
                    },
                  ),
                ),
                BlocBuilder<ThemeCubit, ThemeState>(
                  bloc: getIt<ThemeCubit>(),
                  builder: (context, themeState) {
                    final isDark = themeState is DarkTheme;
                    return ListTile(
                      leading: Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        color: MyColor.primaryColor,
                        size: 24.w,
                      ),
                      title: Text(
                        'theme'.tr(),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      trailing: Switch(
                        activeThumbColor: MyColor.primaryColor,
                        value: isDark,
                        onChanged: (v) => getIt<ThemeCubit>().toggleTheme(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: MyColor.primaryColor,
                    size: 24.w,
                  ),
                  title: Text(
                    'about_me_title'.tr(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AboutMePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.help_outline,
                    color: MyColor.primaryColor,
                  ),
                  title: Text('how_to_use_app'.tr()),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(startTutorial: true),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: ConverterPage(forceShowTutorial: startTutorial),
        );
      },
    );
  }
}
