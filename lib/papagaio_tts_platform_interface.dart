import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'papagaio_tts_method_channel.dart';

abstract class PapagaioTtsPlatform extends PlatformInterface {
  /// Constructs a PapagaioTtsPlatform.
  PapagaioTtsPlatform() : super(token: _token);

  static final Object _token = Object();

  static PapagaioTtsPlatform _instance = MethodChannelPapagaioTts();

  /// The default instance of [PapagaioTtsPlatform] to use.
  ///
  /// Defaults to [MethodChannelPapagaioTts].
  static PapagaioTtsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PapagaioTtsPlatform] when
  /// they register themselves.
  static set instance(PapagaioTtsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
