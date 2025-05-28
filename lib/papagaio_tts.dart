
import 'papagaio_tts_platform_interface.dart';

class PapagaioTts {
  Future<String?> getPlatformVersion() {
    return PapagaioTtsPlatform.instance.getPlatformVersion();
  }
}
