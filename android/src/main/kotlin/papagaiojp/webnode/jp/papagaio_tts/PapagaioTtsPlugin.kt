package papagaiojp.webnode.jp.papagaio_tts

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PapagaioTtsPlugin */
class PapagaioTtsPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "papagaio_tts")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "getSpeakingStatus") {
      result.success(false)
    } else if (call.method == "speak") {
      result.success("speak")
    } else if (call.method == "getLanguage") {
      result.success("en-US")
    } else if (call.method == "getVoice") {
      result.success("Samantha")
    } else if (call.method == "getVoices") {
      println("getVoices")
      result.success(arrayOf("Samantha", "Kyoko").toList())
    } else if (call.method == "getRate") {
      result.success(0.5)
    } else if (call.method == "getVolume") {
      result.success(1.0)
    } else if (call.method == "getPitch") {
      result.success(0.5)
    } else if (call.method == "setLanguage") {
      val language = call.argument<String>("language")?.toString()
      result.success(language)
    } else if (call.method == "setVoice") {
      result.success("Kyoko")
    } else if (call.method == "setRate") {
      result.success(0.5)
    } else if (call.method == "setVolume") {
      result.success(0.5)
    } else if (call.method == "setPitch") {
      result.success(0.5)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun speak(text: String) {
    //println("text ${text})
  }

  // private fun getSpeakingStatus(): boolean {
  //   return tts.getSpeakingStatus()
  // }

  // private fun getVoices(): List<String> {
  //   return tts.getVoices()
  // }

  // private fun getLanguage(): String {
  //   return tts.getLanguage()
  // }

  // private fun getVoice(): String {
  //   return tts.getVoice()
  // }

  // private fun setPitch(pitch: Float): Boolean {
  //   return tts.setPitch(pitch)
  // }

  // private fun setRate(rate: Float): Boolean {
  //   return tts.setRate(rate)
  // }

  // private fun setVolume(volume: Float): Boolean {
  //   return tts.setVolume(volume)
  // }

  // private fun setLanguage(lang: String): Boolean {
  //   return tts.setLanguage(lang)
  // }
}
