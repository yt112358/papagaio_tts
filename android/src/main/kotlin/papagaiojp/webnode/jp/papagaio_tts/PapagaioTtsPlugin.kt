package papagaiojp.webnode.jp.papagaio_tts

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
//  private var methodCallHandler: MethodCallHandlerImpl? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        println("onAttach")
        tts = PapagaioTts(flutterPluginBinding.applicationContext)
        // methodCallHandler = MethodCallHandlerImpl(tts!!)
        // methodCallHandler!!.startListening(flutterPluginBinding.binaryMessenger)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "papagaio_tts")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        // print("call arg ${call.argument} ${call.argument::class.java.typeName}")
        println("call1")
        println("call ${call.arguments.toString()}")
        when (call.method) {
            "getSpeakingStatus" -> {
                result.success(getSpeakingStatus())
            }

            "getVoices" -> {
                result.success(getVoices())
            }

            "getLanguage" -> {
                result.success("en_US")
            }

            "getVoice" -> {
                result.success("en-AU-language")
            }

            "getSpeakingStatus" -> {
                result.success(getSpeakingStatus())
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
                println("setVoice ${voice}")
                if (voice != null) {
                    //result.success(setVoice(voice))
                    setVoice(voice)
                } else {
                    //result.success(false)
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
                speak(text)
            }

            "stop" -> {
                result.success(stop())
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
        //Log.d(PREFIX, "text ${text})
        //println("text ${text}")
        return tts.speak(text)
    }

    private fun getSpeakingStatus(): Boolean {
        return tts.getSpeakingStatus()
        // return false
    }

    private fun getVoices(): List<String> {
        return tts.getVoices()
        //return arrayOf("Samantha", "Kyoko").toList()
    }

    private fun getLanguage(): String {
        return tts.getLanguage()
    }

    private fun getVoice(): String {
        return tts.getVoice()
    }

    private fun getRate(): Float {
        return 1.0f //tts.getVoice().getLatency()
    }

    private fun getPitch(): Float {
        // return tts.getVoice().getPitch()
        return 0.5f
    }

    private fun getVolume(): Float {
        return 1.0f
    }

    private fun setVoice(name: String) {
        //return null
        println("setVoice ${name}")
        tts.setVoice(name)
    }

    private fun setLanguage(language: String) {
        //return null
        println("setLanguage ${language}")
    }

    private fun setRate(rate: Float) {
        //return null
        println("setRate ${rate}")
    }

    private fun setPitch(pitch: Float) {
        //return null
        println("setPitch ${pitch}")
    }

    private fun setVolume(volume: Float) {
        //return null
        println("setVolume ${volume}")
    }

    private fun stop() {
        println("stop")
    }

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
