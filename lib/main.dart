import 'dart:io';

import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/layout.dart';
import 'package:Trackefi/core/presentation/ui/update_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'core/data/database/database_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.isntance.initDatabase();
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowManager.instance.setMinimumSize(const Size(1500, 800));
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn = dotenv.env['SENTRY_DSN'] ?? '';
  //     // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
  //     // We recommend adjusting this value in production.
  //     options.tracesSampleRate = 1.0;
  //   },
  //   appRunner: () => runApp(const ProviderScope(child: MainApp())),
  // );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const UpdateChecker(child: Layout()),
    );
  }
}
