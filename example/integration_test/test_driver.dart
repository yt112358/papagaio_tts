import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final FlutterDriver driver = await FlutterDriver.connect();
  await integrationDriver(
    driver: driver,
    onScreenshot: (name, screenshotBytes, [args]) async {
      final File image = await File(name).create(recursive: true);
      image.writeAsBytesSync(screenshotBytes);
      return true;
    },
  );
}
