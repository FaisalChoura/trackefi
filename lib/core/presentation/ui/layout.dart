import 'dart:async';

import 'package:Trackefi/core/constants.dart';
import 'package:Trackefi/core/presentation/ui/dialog.dart';
import 'package:Trackefi/core/presentation/views/onboarding_screen.dart';
import 'package:Trackefi/features/settings/domain/usecase/check_if_user_is_new_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_menu.dart';

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageKey = ref.watch(selectedPageNameProvider);
  return pages[selectedPageKey]!;
});

class Layout extends ConsumerStatefulWidget {
  const Layout({
    super.key,
  });

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  @override
  void initState() {
    _runTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);
    return Row(
      children: [
        const SizedBox(width: 240, child: AppMenu()),
        Expanded(child: selectedPageBuilder(context))
      ],
    );
  }

  void _runTimer() async {
    final isNewUserUseCase = await ref.read(checkIfUserIsNewUseCaseProvider);
    if (isNewUserUseCase.execute()) {
      Timer(const Duration(seconds: 2), () async {
        await showTrDialog(context, const OnboardingScreen());
      });
    }
  }
}
