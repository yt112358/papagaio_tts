import 'package:flutter_test/flutter_test.dart';
import 'package:papagaio_tts/papagaio_tts.dart';
import 'package:papagaio_tts/papagaio_tts_platform_interface.dart';
import 'package:papagaio_tts/papagaio_tts_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPapagaioTtsPlatform
    with MockPlatformInterfaceMixin
    implements PapagaioTtsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  Future<bool> getSpeakingStatus() {
    // TODO: implement getSpeakingStatus
    throw UnimplementedError();
  }
  
  @override
  Future<List<String>> getVoices() {
    // TODO: implement getVoices
    throw UnimplementedError();
  }
  
  @override
  Future<void> setVoice(String voiceName) {
    // TODO: implement setVoice
    throw UnimplementedError();
  }
  
  @override
  Future<void> speak(String text) {
    // TODO: implement speak
    throw UnimplementedError();
  }
}

void main() {
  final PapagaioTtsPlatform initialPlatform = PapagaioTtsPlatform.instance;

  test('$MethodChannelPapagaioTts is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPapagaioTts>());
  });

  test('getPlatformVersion', () async {
    PapagaioTts papagaioTtsPlugin = PapagaioTts();
    MockPapagaioTtsPlatform fakePlatform = MockPapagaioTtsPlatform();
    PapagaioTtsPlatform.instance = fakePlatform;

    //expect(await papagaioTtsPlugin.getPlatformVersion(), '42');
  });
}
