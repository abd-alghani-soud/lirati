import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lirati/core/constants/my_color.dart';
import 'package:lirati/feature/main/presentation/widgets/social_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  Future<void> _openUrl(BuildContext ctx, String url) async {
    try {
      final uri = Uri.parse(url);

      if (!await canLaunchUrl(uri)) {
        ScaffoldMessenger.of(
          ctx,
        ).showSnackBar(SnackBar(content: Text('cannot_open_link'.tr())));
        return;
      }

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        ScaffoldMessenger.of(
          ctx,
        ).showSnackBar(SnackBar(content: Text('failed_to_open_link'.tr())));
      }
    } catch (e, st) {
      debugPrint('openUrl error: $e\n$st');
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(SnackBar(content: Text('error_opening_link'.tr())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boxBg = isDark
        ? Colors.white.withOpacity(0.06)
        : Colors.black.withOpacity(0.04);
    final boxTextColor = isDark ? Colors.white70 : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.primaryColor,
        title: Text('about_me_title'.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25.h),
            CircleAvatar(
              radius: 45,
              backgroundColor: MyColor.primaryColor,
              child: const Icon(Icons.person, size: 55, color: Colors.white),
            ),
            SizedBox(height: 12.h),
            Text(
              'Abd Alghani Soud'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: MyColor.primaryColor,
              ),
            ),
            SizedBox(height: 18.h),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 0.9.sw,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: boxBg,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'about_me_description'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: boxTextColor,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 22.h),
            SocialTile(
              title: 'instagram'.tr(),
              name: 'assets/logos/instagram.png',
              onTap: () => _openUrl(
                context,
                'https://www.instagram.com/abd_alghani_soud?igsh=MW9tMW96OWpyYTZudQ==',
              ),
            ),
            SocialTile(
              title: 'linkedin'.tr(),
              name: 'assets/logos/linkedin.png',
              onTap: () => _openUrl(
                context,
                'https://www.linkedin.com/in/abd-alghani-soud-2b3a8539b',
              ),
            ),
            SocialTile(
              isGit: true,
              title: 'github'.tr(),
              name: 'assets/logos/github.png',
              onTap: () =>
                  _openUrl(context, 'https://github.com/abd-alghani-soud'),
            ),
            SocialTile(
              title: 'telegram'.tr(),
              name: 'assets/logos/telegram.png',
              onTap: () => _openUrl(context, 'https://t.me/A_soud21'),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
