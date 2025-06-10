package papagaiojp.webnode.jp.papagaio_tts

import android.speech.tts.TextToSpeech
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.*
import kotlin.reflect.typeOf

/** PapagaioTtsPlugin */
class PapagaioTtsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var tts: PapagaioTts
    private var volume: Float = 1.0f
    private var rate: Float = 0.5f
    private var pitch: Float = 0.5f

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        tts = PapagaioTts(flutterPluginBinding.applicationContext)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "papagaio_tts")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getSpeakingStatus" -> {
                result.success(getSpeakingStatus())
            }

            "getVoices" -> {
                result.success(getVoices())
            }

            "getAvailableLanguages" -> {
                val filterLanguages = call.arguments as List<String>
                result.success(getAvailableLanguages(filterLanguages))
            }

            "getLanguage" -> {
                result.success(getLanguage())
            }

            "getVoice" -> {
                result.success(getVoice())
            }

            "getRate" -> {
                result.success(getRate())
            }

            "getPitch" -> {
                result.success(getPitch())
            }

            "getVolume" -> {
                result.success(getVolume())
            }

            "setLanguage" -> {
                val language = call.arguments.toString()
                if (language != null) {
                    result.success(setLanguage(language))
                } else {
                    result.success(false)
                }
            }

            "setVoice" -> {
                // TODO
                val voice = call.arguments.toString()
                if (voice != null) {
                    result.success(setVoice(voice))
                    //setVoice(voice)
                } else {
                    result.success(false)
                }
            }

            "setRate" -> {
                val rate = call.arguments.toString().toFloat()
                if (rate != null) {
                    setRate(rate)
                }
            }

            "setPitch" -> {
                val pitch = call.arguments.toString().toFloat()
                if (pitch != null) {
                    setPitch(pitch)
                }
            }

            "setVolume" -> {
                val volume = call.arguments.toString().toFloat()
                if (volume != null) {
                    setVolume(volume)
                }
            }

            "speak" -> {
                val text = call.arguments.toString().toString()
                // TODO return
                speak(text)
            }

            "stop" -> {
                result.success(stop())
            }

            "shutdown" -> {
                shutdown()
            }

            else -> {
                result.notImplemented()
            }
        }
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else if (call.method == "getSpeakingStatus") {
//      result.success(getSpeakingStatus())
//    } else if (call.method == "speak") {
//      result.success("speak")
//    } else if (call.method == "getLanguage") {
//      result.success("en-US")
//    } else if (call.method == "getVoice") {
//      result.success("Samantha")
//    } else if (call.method == "getVoices") {
//      println("getVoices")
//      //result.success(arrayOf("Samantha", "Kyoko").toList())
//      result.success(getVoices())
//    } else if (call.method == "getRate") {
//      result.success(0.5)
//    } else if (call.method == "getVolume") {
//      result.success(1.0)
//    } else if (call.method == "getPitch") {
//      result.success(0.5)
//    } else if (call.method == "setLanguage") {
//      val language = call.argument<String>("language")?.toString()
//      result.success(language)
//    } else if (call.method == "setVoice") {
//      result.success("Kyoko")
//    } else if (call.method == "setRate") {
//      result.success(0.5)
//    } else if (call.method == "setVolume") {
//      result.success(0.5)
//    } else if (call.method == "setPitch") {
//      result.success(0.5)
//    } else {
//      result.notImplemented()
//    }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun speak(text: String): Boolean {
        return tts.speak(text, volume)
    }

    private fun getSpeakingStatus(): Boolean {
        println("getSpeakingStatus ${tts.getSpeakingStatus()}")
        return tts.getSpeakingStatus()
    }

    private fun getAvailableLanguages(filterLanguages: List<String>): List<String> {
        return tts.getAvailableLanguages(filterLanguages)
    }

    private fun getVoices(): List<String> {
        return tts.getVoices()
    }

    private fun getLanguage(): String {
        return tts.getLanguage()
    }

    private fun getVoice(): String {
        return tts.getVoice()
    }

    private fun getRate(): Float {
        return this.rate
    }

    private fun getPitch(): Float {
        return this.pitch
    }

    private fun getVolume(): Float {
        return this.volume
    }

    private fun setVoice(name: String): Boolean {
        return tts.setVoice(name)
    }

    private fun setLanguage(language: String): Boolean {
        return tts.setLanguage(language)
    }

    private fun setRate(rate: Float): Boolean {
        val result = tts.setRate(rate)
        if (result) {
            this.rate = rate
            return true
        }
        return false
    }

    private fun setPitch(pitch: Float): Boolean {
        val result = tts.setPitch(pitch)
        if (result) {
            this.pitch = pitch
            return true
        }
        return false
    }

    private fun setVolume(volume: Float): Boolean {
        this.volume = volume
        return true
    }

    private fun stop(): Boolean {
        return tts.stop()
    }

    private fun shutdown() {
        tts.shutdown()
    }
}
