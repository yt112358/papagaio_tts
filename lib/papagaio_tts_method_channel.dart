import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'papagaio_tts_platform_interface.dart';

/// An implementation of [PapagaioTtsPlatform] that uses method channels.
class MethodChannelPapagaioTts extends PapagaioTtsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('papagaio_tts');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
