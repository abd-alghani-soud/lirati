import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:easy_localization/easy_localization.dart';

class ConverterTutorialManager {
  final BuildContext context;
  final GlobalKey menuKey;
  final GlobalKey rateKey;
  final GlobalKey amountKey;
  final GlobalKey resultKey;
  final VoidCallback? onStart;
  final VoidCallback? onFinish;

  TutorialCoachMark? _tutorialCoachMark;

  ConverterTutorialManager({
    required this.context,
    required this.menuKey,
    required this.rateKey,
    required this.amountKey,
    required this.resultKey,
    this.onStart,
    this.onFinish,
  });

  void show() {
    onStart?.call();

    _tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      opacityShadow: 0.8,
      textSkip: 'skip'.tr(),
      paddingFocus: 10,
      onFinish: () => onFinish?.call(),
      onSkip: () {
        onFinish?.call();
        return true;
      },
    );

    _tutorialCoachMark?.show(context: context);
  }

  List<TargetFocus> _createTargets() {
    return [
      TargetFocus(
        identify: "menu",
        keyTarget: menuKey,
        shape: ShapeLightFocus.Circle,
        contents: [
          _content(
            'tutorial_menu_title',
            'tutorial_menu_description',
            showNext: true,
          ),
        ],
      ),
      TargetFocus(
        identify: "rate",
        keyTarget: rateKey,
        shape: ShapeLightFocus.RRect,
        radius: 15,
        paddingFocus: 5,
        contents: [
          _content(
            'tutorial_rate_title',
            'tutorial_rate_description',
            showNext: true,
          ),
        ],
      ),
      TargetFocus(
        identify: "amount",
        keyTarget: amountKey,
        shape: ShapeLightFocus.RRect,
        radius: 15,
        paddingFocus: 5,
        contents: [
          _content(
            'tutorial_amount_title',
            'tutorial_amount_description',
            showNext: true,
          ),
        ],
      ),
      TargetFocus(
        identify: "result",
        keyTarget: resultKey,
        shape: ShapeLightFocus.RRect,
        radius: 15,
        contents: [
          _content(
            'tutorial_result_title',
            'tutorial_result_description',
            showFinish: true,
          ),
        ],
      ),
    ];
  }

  TargetContent _content(
    String titleKey,
    String bodyKey, {
    bool showNext = false,
    bool showFinish = false,
  }) {
    return TargetContent(
      align: ContentAlign.bottom,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleKey.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(bodyKey.tr(), style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 16),
          if (showNext)
            ElevatedButton(
              onPressed: () => _tutorialCoachMark?.next(),
              child: Text('next'.tr()),
            ),
          if (showFinish)
            ElevatedButton(
              onPressed: () => _tutorialCoachMark?.finish(),
              child: Text('done'.tr()),
            ),
        ],
      ),
    );
  }
}
