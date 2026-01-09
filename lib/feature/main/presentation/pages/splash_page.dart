import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lirati/core/constants/my_color.dart';
import 'package:lirati/core/constants/my_images.dart';
import 'package:lirati/feature/main/presentation/pages/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textPosition;
  late final Animation<double> _imageOpacity;
  late final Animation<Offset> _imagePosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _initializeAnimations();
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false,
        );
      }
    });
  }

  void _initializeAnimations() {
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );
    _textPosition =
        Tween<Offset>(
          begin: const Offset(0, -0.2),
          end: const Offset(0, 0.22),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.6, curve: Curves.easeInOut),
          ),
        );

    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );
    _imagePosition =
        Tween<Offset>(
          begin: const Offset(0, -1.5),
          end: const Offset(0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.background,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _imageOpacity.value,
                  child: Transform.translate(
                    offset: Offset(
                      _imagePosition.value.dx * 1.sw,
                      _imagePosition.value.dy * 1.sh,
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.appIcon,
                        width: 600.w,
                        height: 250.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _textOpacity.value,
                  child: Transform.translate(
                    offset: Offset(
                      _textPosition.value.dx * 1.sw,
                      _textPosition.value.dy * 1.sh,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'logo_name'.tr(),
                            style: TextStyle(
                              color: MyColor.primaryColor,
                              fontSize: 75.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          SizedBox(
                            width: 200.w,
                            child: LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                MyColor.primaryColor,
                              ),
                              backgroundColor: MyColor
                                  .backgroundColorLinearProgressIndicator,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
