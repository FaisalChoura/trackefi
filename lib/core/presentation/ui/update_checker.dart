import 'dart:async';
import 'dart:convert';

import 'package:Trackefi/core/presentation/ui/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker extends ConsumerWidget {
  final Widget child;
  const UpdateChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _runTimer(context);
    return child;
  }

  // TODO env var for url
  // TODO extract to DDD pattern
  // TODO create version comaprison
  void _runTimer(BuildContext context) async {
    final response = await http.get(
        Uri.parse('https://trackefi-api.onrender.com/api/v1/releases/latest'));
    VersionPayload version;
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      version = VersionPayload.fromJson(json);
    } else {
      throw Exception('Failed to load update url');
    }

    final Uri url = Uri.parse(version.downloadLinks["macos"]);
    if (true) {
      Timer(const Duration(seconds: 2), () async {
        await showTrDialog(
            context,
            SizedBox(
              height: 120,
              width: 400,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'New version available',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Version '${version.version}' is now available!"),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () => _launchUrl(url),
                          child: const Text('Click here to download')),
                    )
                  ]),
            ));
      });
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class VersionPayload {
  final String version;
  final dynamic downloadLinks;
  VersionPayload({required this.version, required this.downloadLinks});

  factory VersionPayload.fromJson(dynamic json) {
    return VersionPayload(
        version: json["version"], downloadLinks: json["downloadLinks"]);
  }
}
