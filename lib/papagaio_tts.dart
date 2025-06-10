import 'papagaio_tts_platform_interface.dart';

class PapagaioTts {
  Future<List<String>> getVoices() {
    var result = PapagaioTtsPlatform.instance.getVoices();
    return Future<List<String>>.value(result);
  }

  Future<List<String>> getAvailableLanguages(List<String>? filterLanguages) {
    var result = PapagaioTtsPlatform.instance.getAvailableLanguages(filterLanguages);
    return Future<List<String>>.value(result);
  }

  Future<bool> speak(String text) {
    final result = PapagaioTtsPlatform.instance.speak(text);
    return Future<bool>.value(result);
  }

  Future<bool> stop() {
    final result = PapagaioTtsPlatform.instance.stop();
    return Future<bool>.value(result);
  }

  Future<void> shutdown() {
    PapagaioTtsPlatform.instance.shutdown();
    return Future<void>.value();
  }

  Future<bool> getSpeakingStatus() {
    return PapagaioTtsPlatform.instance.getSpeakingStatus();
  }

  Future<String> getLanguage() {
    return PapagaioTtsPlatform.instance.getLanguage();
  }

  Future<String> getVoice() {
    return PapagaioTtsPlatform.instance.getVoice();
  }

  Future<num> getRate() {
    return PapagaioTtsPlatform.instance.getRate();
  }

  Future<num> getVolume() {
    return PapagaioTtsPlatform.instance.getVolume();
  }

  Future<num> getPitch() {
    return PapagaioTtsPlatform.instance.getPitch();
  }

  Future<bool> setVoice(String voiceName) {
    final result = PapagaioTtsPlatform.instance.setVoice(voiceName);
    return Future<bool>.value(result);
  }

  Future<bool> setLanguage(String language) {
    final result = PapagaioTtsPlatform.instance.setLanguage(language);
    return Future<bool>.value(result);
  }

  Future<bool> setRate(num rate) {
    final result = PapagaioTtsPlatform.instance.setRate(rate);
    return Future<bool>.value(result);
  }

  Future<bool> setVolume(num volume) {
    final result = PapagaioTtsPlatform.instance.setVolume(volume);
    return Future<bool>.value(result);
  }

  Future<bool> setPitch(num pitch) {
    final result = PapagaioTtsPlatform.instance.setPitch(pitch);
    return Future<bool>.value(result);
  }
}
