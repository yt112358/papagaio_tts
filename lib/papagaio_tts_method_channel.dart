import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'papagaio_tts_platform_interface.dart';

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

  @override
  Future<List<dynamic>> getAvailableLanguages(List<String>? filterLanguages) async {
    final result = await methodChannel.invokeMethod<List<dynamic>>('getAvailableLanguages', filterLanguages) ?? [[]];
    return Future<List<dynamic>>.value(result);
  }

  @override
  Future<bool> speak(String text) async {
    final result = await methodChannel.invokeMethod<bool>('speak', text);
    return Future<bool>.value(result);
  }

  @override
  Future<bool> stop() async {
    final result = await methodChannel.invokeMethod<bool>('stop');
    return Future<bool>.value(result);
  }

  @override
  Future<void> shutdown() async {
    await methodChannel.invokeMethod<void>('shutdown');
    return Future<void>.value();
  }


  @override
  Future<bool> getSpeakingStatus() async {
    final result = await methodChannel.invokeMethod<bool>('getSpeakingStatus');
    return Future<bool>.value(result);
  }

  @override
  Future<String> getLanguage() async {
    final result = await methodChannel.invokeMethod<String>('getLanguage');
    return Future<String>.value(result);
  }
  @override
  Future<String> getVoice() async {
    final result = await methodChannel.invokeMethod<String>('getVoice');
    return Future<String>.value(result);
  }
  @override
  Future<num> getRate() async {
    final result = await methodChannel.invokeMethod<num>('getRate');
    return Future<num>.value(result);
  }
  @override
  Future<num> getVolume() async {
    final result = await methodChannel.invokeMethod<num>('getVolume');
    return Future<num>.value(result);
  }
  @override
  Future<num> getPitch() async {
    final result = await methodChannel.invokeMethod<num?>('getPitch');
    return Future<num>.value(result);
  }

  @override
  Future<bool> setVoice(String voiceName) async {
    final result = await methodChannel.invokeMethod<bool>('setVoice', voiceName);
    return Future<bool>.value(result);
  }

  @override
  Future<bool> setLanguage(String language, String? country) async {
    var args = [language];
    if (country != null) {
      args.add(country);
    }
    final result = await methodChannel.invokeMethod<bool>('setLanguage', args);
    return Future<bool>.value(result);
  }

  @override
  Future<bool> setRate(num rate) async {
    bool? result = await methodChannel.invokeMethod<bool>('setRate', rate);
    return Future<bool>.value(result);
  }

  @override
  Future<bool> setVolume(num volume) async {
    final result = await methodChannel.invokeMethod<bool>('setVolume', volume);
    return Future<bool>.value(result);
  }

  @override
  Future<bool> setPitch(num pitch) async {
    final result = await methodChannel.invokeMethod<bool>('setPitch', pitch);
    return Future<bool>.value(result);
  }
}
