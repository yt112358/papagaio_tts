// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:papagaio_tts/papagaio_tts.dart';
import 'package:flutter/material.dart';
import 'package:papagaio_tts_example/main.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  //IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // testWidgets('getLanguage test', (WidgetTester tester) async {
  //   final PapagaioTts plugin = PapagaioTts();
  //   final Locale language = await plugin.getLanguage();
  //   expect(language, const Locale("en", "US"));
  // });

  testWidgets('screen appearance test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final label = find.byWidgetPredicate((Widget widget) => widget is Text && widget.data == 'Plugin example app');
    await tester.pumpUntilFound(label);
    expect(find.byWidgetPredicate((Widget widget) => widget is Text && widget.data == 'Plugin example app'), findsOneWidget);
    final first = find.byWidgetPredicate((Widget widget) => widget is DropdownMenu).first;
    await tester.pumpUntilFound(first);
    await tester.tap(first);

    final last = find.byWidgetPredicate((Widget widget) => widget is DropdownMenu).last;
    await tester.pumpUntilFound(last);
    await tester.tap(last);

    final firstButton = find.byWidgetPredicate((Widget widget) => widget is IconButton).first;
    await tester.pumpUntilFound(firstButton);
    await tester.press(firstButton);

    final lastButton = find.byWidgetPredicate((Widget widget) => widget is IconButton).last;
    await tester.pumpUntilFound(lastButton);
    await tester.press(lastButton);



//  final directory = await getApplicationDocumentsDirectory();
  // final imagePath = '${directory.path}/screenshot.png';
  // print("imagePath $imagePath");
  // check
  // final existsFile = await File(imagePath);
  // if(await existsFile.exists()) {
  //   existsFile.delete();
  // }
    // TODO 値をチェックする
    // TODO パーツ一つずつに分ける
    // TODO ここで落ちる　実機を繋げてやってみる
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot("snapshot.png");


    // final local = Directory('./screenshots');
    // if (!local.existsSync()) {
    //   local.createSync();
    // }
    // //File('./screenshots/$name.png').writeAsBytesSync(bytes);
    // final file = File(imagePath);
    // await file.copy("./screenshots/capture.png");
  });
}

extension TestUtilEx on WidgetTester {
  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 30),
    String description = '',
  }) async {
    var found = false;
    final timer = Timer(
      timeout,
      () => throw TimeoutException('Pump until has timed out $description'),
    );
    while (!found) {
      await pump();
      found = any(finder);
    }
    timer.cancel();
  }
}
// Android
// flutter test integration_test/plugin_integration_test.dart -d emulator-5554
// /data/user/0/papagaiojp.webnode.jp.papagaio_tts.papagaio_tts_example/app_flutter/screenshot.png

//flutter drive --driver=./integration_test/test_driver.dart --target integration_test/plugin_integration_test.dart  -d emulator-5556