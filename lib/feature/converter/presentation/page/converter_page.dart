import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lirati/core/services/dependecies.dart';
import 'package:lirati/feature/converter/presentation/widgets/converter_controller.dart';
import '../blocs/currency/currency_bloc.dart';
import '../widgets/converter_sliver_app_bar.dart';
import '../widgets/converter_body.dart';
import '../widgets/converter_tutorial_manager.dart';

class ConverterPage extends StatefulWidget {
  final bool forceShowTutorial;

  const ConverterPage({super.key, this.forceShowTutorial = false});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  late final ConverterController controller;
  late final ConverterTutorialManager _tutorialManager;

  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _amountKey = GlobalKey();
  final GlobalKey _resultKey = GlobalKey();

  final ValueNotifier<bool> _isTutorialActive = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    controller = ConverterController(getIt<CurrencyBloc>());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _tutorialManager = ConverterTutorialManager(
        context: context,
        menuKey: _menuKey,
        amountKey: _amountKey,
        resultKey: _resultKey,
        onStart: () => _isTutorialActive.value = true,
        onFinish: () => _isTutorialActive.value = false,
      );

      _maybeShowOnboarding();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _isTutorialActive.dispose();
    super.dispose();
  }

  Future<void> _maybeShowOnboarding() async {
    if (widget.forceShowTutorial) {
      _tutorialManager.show();
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seen_onboarding') ?? false;

    if (!seen) {
      _tutorialManager.show();
      await prefs.setBool('seen_onboarding', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isTutorialActive,
      builder: (context, isActive, _) {
        return CustomScrollView(
          physics: isActive
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          slivers: [
            ConverterSliverAppBar(menuKey: _menuKey),
            SliverToBoxAdapter(
              child: ConverterBody(
                controller: controller,
                amountKey: _amountKey,
                resultKey: _resultKey,
              ),
            ),
          ],
        );
      },
    );
  }
}
