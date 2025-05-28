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

    Future<void> setVoice(String voiceName) async {
      //TextToSpeechPlatform.instance.setLanguage(voiceName);
      await methodChannel.invokeMethod<void>('setVoice', voiceName);
    }

    Future<void> speak(String text) async {
      //TextToSpeechPlatform.instance.setLanguage(voiceName);
      await methodChannel.invokeMethod<void>('speak', text);
    }

    Future<bool> getSpeakingStatus() async {
      //TextToSpeechPlatform.instance.setLanguage(voiceName);
      final result = await methodChannel.invokeMethod<bool>('getSpeakingStatus');
      return Future<bool>.value(result);
    }
}
