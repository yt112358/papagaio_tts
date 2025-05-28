
import 'papagaio_tts_platform_interface.dart';

class PapagaioTts {

  Future<List<String>> getVoices() {
    var result = PapagaioTtsPlatform.instance.getVoices();
    print("#### plugin getVoice result ${result}");
    return Future<List<String>>.value(result);
  }

  Future<void> setVoice(String voiceName) {
    PapagaioTtsPlatform.instance.setVoice(voiceName);
    return Future<void>.value();
  }

  Future<void> speak(String text) {
    PapagaioTtsPlatform.instance.speak(text);
    return Future<void>.value();
  }

  // getSpeakingStatus
  Future<bool> getSpeakingStatus() {
    return PapagaioTtsPlatform.instance.getSpeakingStatus();
  }
}
