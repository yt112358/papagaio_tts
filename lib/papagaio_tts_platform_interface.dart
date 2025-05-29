import 'dart:ffi';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'papagaio_tts_method_channel.dart';

abstract class PapagaioTtsPlatform extends PlatformInterface {
  PapagaioTtsPlatform() : super(token: _token);

  static final Object _token = Object();

  static PapagaioTtsPlatform _instance = MethodChannelPapagaioTts();

  static PapagaioTtsPlatform get instance => _instance;

  static set instance(PapagaioTtsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<String>> getVoices() {
    throw UnimplementedError('getVoices() has not been implemented.');
  }

  Future<void> speak(String text) {
    throw UnimplementedError('speak() has not been implemented.');
  }

  Future<bool> getSpeakingStatus() {
    throw UnimplementedError('getSpeakingStatus() has not been implemented.');
  }

  Future<void> setVoice(String voiceName) {
    throw UnimplementedError('setVoice() has not been implemented.');
  }

  Future<void> setLanguage(String language) {
    throw UnimplementedError('setLanguage() has not been implemented.');
  }

  Future<void> setRate(num rate) {
    throw UnimplementedError('setRate() has not been implemented.');
  }

  Future<void> setVolume(num volume) {
    throw UnimplementedError('setVolume() has not been implemented.');
  }

  Future<void> setPitch(num pitch) {
    throw UnimplementedError('setPitch() has not been implemented.');
  }
}
