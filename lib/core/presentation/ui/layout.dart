import 'dart:async';

import 'package:Trackefi/core/constants.dart';
import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/dialog.dart';
import 'package:Trackefi/core/presentation/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_menu.dart';

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageKey = ref.watch(selectedPageNameProvider);
  return pages[selectedPageKey]!;
});

class Layout extends ConsumerWidget {
  const Layout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);
    Timer(const Duration(seconds: 2), () {
      showTrDialog(context, const OnboardingScreen());
    });
    return Row(
      children: [
        const SizedBox(width: 240, child: AppMenu()),
        Expanded(child: selectedPageBuilder(context))
      ],
    );
  }
}
