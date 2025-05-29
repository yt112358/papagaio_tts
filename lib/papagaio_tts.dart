import 'papagaio_tts_platform_interface.dart';

class PapagaioTts {
  Future<List<String>> getVoices() {
    var result = PapagaioTtsPlatform.instance.getVoices();
    return Future<List<String>>.value(result);
  }

  Future<void> speak(String text) {
    PapagaioTtsPlatform.instance.speak(text);
    return Future<void>.value();
  }

  Future<void> stop() {
    PapagaioTtsPlatform.instance.stop();
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

  Future<void> setVoice(String voiceName) {
    PapagaioTtsPlatform.instance.setVoice(voiceName);
    return Future<void>.value();
  }

  Future<void> setLanguage(String language) {
    PapagaioTtsPlatform.instance.setLanguage(language);
    return Future<void>.value();
  }

  Future<void> setRate(num rate) {
    PapagaioTtsPlatform.instance.setRate(rate);
    return Future<void>.value();
  }

  Future<void> setVolume(num volume) {
    PapagaioTtsPlatform.instance.setVolume(volume);
    return Future<void>.value();
  }

  Future<void> setPitch(num pitch) {
    PapagaioTtsPlatform.instance.setPitch(pitch);
    return Future<void>.value();
  }
}
