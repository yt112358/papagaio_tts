import 'dart:ui';

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

  Future<List<dynamic>> getAvailableLanguages(List<String>? filterLanguages) {
    throw UnimplementedError('getAvailableLanguages() has not been implemented.');
  }

  Future<bool> speak(String text) {
    throw UnimplementedError('speak() has not been implemented.');
  }

  Future<bool> stop() {
    throw UnimplementedError('stop() has not been implemented.');
  }

  Future<void> shutdown() {
    throw UnimplementedError('shutdown() has not been implemented.');
  }

  Future<bool> getSpeakingStatus() {
    throw UnimplementedError('getSpeakingStatus() has not been implemented.');
  }

  Future<String> getLanguage() {
    throw UnimplementedError('getLanguage() has not been implemented.');
  }

  Future<String> getVoice() {
    throw UnimplementedError('getVoice() has not been implemented.');
  }

  Future<num> getRate() {
    throw UnimplementedError('getRate() has not been implemented.');
  }

  Future<num> getVolume() {
    throw UnimplementedError('getVolume() has not been implemented.');
  }

  Future<num> getPitch() {
    throw UnimplementedError('getPitch() has not been implemented.');
  }

  Future<bool> setVoice(String voiceName) {
    throw UnimplementedError('setVoice() has not been implemented.');
  }

  Future<bool> setLanguage(String language, String? country) {
    throw UnimplementedError('setLanguage() has not been implemented.');
  }

  Future<bool> setRate(num rate) {
    throw UnimplementedError('setRate() has not been implemented.');
  }

  Future<bool> setVolume(num volume) {
    throw UnimplementedError('setVolume() has not been implemented.');
  }

  Future<bool> setPitch(num pitch) {
    throw UnimplementedError('setPitch() has not been implemented.');
  }
}
