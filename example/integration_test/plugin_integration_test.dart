// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction

import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:papagaio_tts/papagaio_tts.dart';
import 'package:flutter/material.dart';
import 'package:papagaio_tts_example/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getLanguage test', (WidgetTester tester) async {
    final PapagaioTts plugin = PapagaioTts();
    final Locale language = await plugin.getLanguage();
    expect(language, const Locale("en", "US"));
  });

  testWidgets('screen appearance test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();
    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is Text && widget.data == 'Plugin example app'),
        findsOneWidget);
    final langDropdown = find.byType(DropdownMenu<Locale>);
    //await tester.pumpUntilFound(langDropdown);
    await tester.pumpAndSettle();
    await tester.tap(langDropdown);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final langItem = find.byWidgetPredicate((widget) {
      if (widget is RichText && widget.text.toPlainText() == "en_US") {
        return true;
      }
      return false;
    });
    await tester.tap(langItem);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    var platformTye = Platform.operatingSystem;

    if (platformTye == "ios") {
      await binding.convertFlutterSurfaceToImage();
      await binding
          .takeScreenshot("snapshot_${platformTye}_${DateTime.now()}.png");
    }
  });
}

// extension TestUtilEx on WidgetTester {
//   Future<void> pumpUntilFound(
//     Finder finder, {
//     Duration timeout = const Duration(seconds: 10),
//     String description = '',
//   }) async {
//     var found = false;
//     final timer = Timer(
//       timeout,
//       () => throw TimeoutException('Pump until has timed out $description'),
//     );
//     while (!found) {
//       await pump();
//       found = any(finder);
//     }
//     timer.cancel();
//   }
// }
// For IOS
// flutter drive --driver=./integration_test/test_driver.dart --target integration_test/plugin_integration_test.dart -d 67FB8815-CFF5-419D-8905-8735C73A47D3