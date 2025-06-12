import 'dart:ui';

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
          case "getSpeakingStatus":
            return false;
          case "getAvailableLanguages":
            return [["en","US"], ["ja", "JP"]];
          case "getVoices":
            return ["Samantha", "Kyoko"];
          case "getVoice":
            return "Samantha";
          case "getLanguage":
            return ["en","US"];
          case "getVolume":
            return 1.0;
          case "getRate":
            return 0.5;
          case "getPitch":
            return 0.5;
          case "speak":
            return true;
          case "stop":
            return true;
          case "shutdown":
            return null;
          case "setLanugage":
            return true;
          case "setVoice":
            return true;
          case "setVolume":
            return true;
          case "setRate":
            return true;
          case "setPitch":
            return true;
          default:
            return false;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getSpeakingStatus', () async {
    expect(await platform.getSpeakingStatus(), false);
  });
  test('getAvailableLanguages', () async {
    expect(await platform.getAvailableLanguages([]), [["en", "US"], ["ja", "JP"]]);
  });
  test('getVoices', () async {
    expect(await platform.getVoices(), ["Samantha", "Kyoko"]);
  });
  test('getVoice', () async {
    expect(await platform.getVoice(), "Samantha");
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
  test('stop', () async {
    expect(await platform.stop(), true);
  });
  test('shutdown', () async {
    await platform.shutdown();
  });
  test('setLanguage', () async {
    expect(await platform.setLanguage("en_US"), true);
  });
  test('setVoice', () async {
    expect(await platform.setVoice("Samantha"), true);
  });
  test('setVolume', () async {
    expect(await platform.setVolume(1.0), true);
  });
  test('setRate', () async {
    expect(await platform.setRate(1.0), true);
  });
  test('setPitch', () async {
    expect(await platform.setPitch(1.0), true);
  });
}
