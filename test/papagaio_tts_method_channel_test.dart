import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papagaio_tts/papagaio_tts_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPapagaioTts platform = MethodChannelPapagaioTts();
  const MethodChannel channel = MethodChannel('papagaio_tts');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case "getVoices":
            return ["Samantha", "Kyoko"];
          case "getLanguage":
            return "en-US";
          case "getRate":
            return 0.5;
          case "getVolume":
            return 1.0;
          case "getPitch":
            return 0.5;
          default:
            return false;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getVoices', () async {
    expect(await platform.getVoices(), ["Samantha", "Kyoko"]);
  });
  test('getLanguage', () async {
    expect(await platform.getLanguage(), "en-US");
  });
  test('getRate', () async {
    expect(await platform.getRate(), 0.5);
  });
  test('getVolume', () async {
    expect(await platform.getVolume(), 1.0);
  });
  test('getPitch', () async {
    expect(await platform.getPitch(), 0.5);
  });
}
