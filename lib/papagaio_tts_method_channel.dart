import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'papagaio_tts_platform_interface.dart';
import 'dart:ffi';

/// An implementation of [PapagaioTtsPlatform] that uses method channels.
class MethodChannelPapagaioTts extends PapagaioTtsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('papagaio_tts');

  @override
  Future<List<String>> getVoices() async {
    List<dynamic>? result = await methodChannel.invokeMethod<List<dynamic>>('getVoices') ?? [];
    List<String> convResult = result.map((v) => v as String).toList();

    return Future<List<String>>.value(convResult);
  }

  Future<void> speak(String text) async {
    await methodChannel.invokeMethod<void>('speak', text);
  }

  Future<bool> getSpeakingStatus() async {
    final result = await methodChannel.invokeMethod<bool>('getSpeakingStatus');
    return Future<bool>.value(result);
  }

  Future<void> setVoice(String voiceName) async {
    await methodChannel.invokeMethod<void>('setVoice', voiceName);
  }

  Future<void> setLanguage(String language) async {
    await methodChannel.invokeMethod<void>('setLanguage', language);
  }

  Future<void> setRate(num rate) async {
    await methodChannel.invokeMethod<void>('setRate', rate);
    return Future<void>.value();
  }

  Future<void> setVolume(num volume) async {
    await methodChannel.invokeMethod<void>('setVolume', volume);
    return Future<void>.value();
  }

  Future<void> setPitch(num pitch) async {
    await methodChannel.invokeMethod<void>('setPitch', pitch);
    return Future<void>.value();
  }
}
