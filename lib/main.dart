import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lirati/feature/main/presentation/pages/splash_page.dart';
import 'core/services/dependecies.dart';
import 'core/cubit/theme_cubit.dart';
import 'package:lirati/core/services/shared_preferences_service.dart';
import 'package:lirati/core/utils/theme/light/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPreferencesService.init();
  configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const LiratiApp(),
    ),
  );
}

class LiratiApp extends StatelessWidget {
  const LiratiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final isArabic = currentLocale.languageCode == 'ar';

    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: getIt<ThemeCubit>(),
      builder: (context, state) {
        final theme = state is DarkTheme
            ? AppTheme.dark(isArabic: isArabic)
            : AppTheme.light(isArabic: isArabic);

        return ScreenUtilInit(
          designSize: const Size(414, 930),
          enableScaleText: () => false,
          fontSizeResolver: (fontSize, instance) {
            return fontSize.toDouble();
          },
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'Lirati',
              debugShowCheckedModeBanner: false,
              theme: theme,
              locale: currentLocale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: child,
            );
          },
          child: SplashPage(),
        );
      },
    );
  }
}
