package papagaiojp.webnode.jp.papagaio_tts

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.*

/** PapagaioTtsPlugin */
class PapagaioTtsPlugin : FlutterPlugin, MethodCallHandler {
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
                val language = call.arguments as? List<String>
                println("language $language")
                if (language != null) {
                    result.success(setLanguage(language))
                } else {
                    result.success(false)
                }
            }

            "setVoice" -> {
                val voice = call.arguments.toString()
                if (voice != null) {
                    result.success(setVoice(voice))
                } else {
                    result.success(false)
                }
            }

            "setRate" -> {
                val rate = call.arguments.toString().toFloat()
                if (rate != null) {
                    result.success(setRate(rate))
                } else {
                    result.success(false)
                }
            }

            "setPitch" -> {
                val pitch = call.arguments.toString().toFloat()
                if (pitch != null) {
                    result.success(setPitch(pitch))
                } else {
                    result.success(false)
                }
            }

            "setVolume" -> {
                val volume = call.arguments.toString().toFloat()
                if (volume != null) {
                    result.success(setVolume(volume))
                } else {
                    result.success(false)
                }
            }

            "speak" -> {
                val text = call.arguments.toString().toString()
                result.success(speak(text))
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
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun speak(text: String): Boolean {
        return tts.speak(text, volume)
    }

    private fun getSpeakingStatus(): Boolean {
        return tts.getSpeakingStatus()
    }

    private fun getAvailableLanguages(filterLanguages: List<String>): List<List<String>> {
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

    private fun setLanguage(language: List<String>): Boolean {
        return tts.setLanguage(language[0], language[1])
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
