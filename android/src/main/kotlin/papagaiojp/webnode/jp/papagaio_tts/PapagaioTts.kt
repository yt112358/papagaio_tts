package papagaiojp.webnode.jp.papagaio_tts


import android.content.Context
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.speech.tts.Voice
import java.util.Locale


class PapagaioTts(context: Context) {
    private lateinit var textToSpeech: TextToSpeech
    init {
        textToSpeech = TextToSpeech(context) { status ->
            if (status == TextToSpeech.SUCCESS) {
                textToSpeech.language = Locale.ENGLISH
            }
        }
    }

    fun speak(text: String): Boolean {
        println("speak")
//        val params = Bundle()
//        params.putFloat(TextToSpeech.Engine.KEY_PARAM_VOLUME, 1.0f)
//        textToSpeech.language = Locale.ENGLISH
//        //
//        textToSpeech.setSpeechRate(0.5f)
//        textToSpeech.setPitch(0.5f)
//        //textToSpeech?.volume = 1.0f
//        // textToSpeech?.setVoice("Samantha")
//        val result = textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, params, "utteranceId1")
//        return result == TextToSpeech.SUCCESS
        val params = Bundle()
        params.putFloat(TextToSpeech.Engine.KEY_PARAM_VOLUME, 1.0f)
        val result = textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, params, "")
        return result == TextToSpeech.SUCCESS
    }

    fun getVoices(): List<String> {
        //return listOf("Samantha").toList()
        val voices: Set<Voice> = textToSpeech.voices
        println("voices[0] ${voices.toList()[0].locale.toLanguageTag()}")
        val lang = getLanguage()
        println("lang $lang")
        val voiceNames: List<String> = voices.filter { it.locale.toString().startsWith(lang) }.map<Voice, String> { it.name }.toList()
        println("voiceNames ${voiceNames}")
        return voiceNames
    }

    fun getVoice(): String {
        return textToSpeech.defaultVoice.name
    }

    fun getLanguage(): String {
        // println("lang ${Locale.ENGLISH.toString()}")
        return Locale.ENGLISH.toString()
    }
    
    fun getSpeakingStatus(): Boolean {
        return textToSpeech.isSpeaking()
    }

    fun getRate(): Float {
        return 0.5f
    }

    fun getPitch(): Float {
        return 0.5f
    }
    fun getVolume(): Float {
        return 1.0f
    }
    
    fun setVoice(voiceName: String) {
        val voice: Voice = textToSpeech.voices.filter { it.name == voiceName }.get(0)
        textToSpeech.setVoice(voice)
    }
}
//
//class PapagaioTts(context: Context) {
//
//    private var textToSpeech: TextToSpeech? = null
//
//    init {
//        textToSpeech = TextToSpeech(context) { status ->
//            if (status == TextToSpeech.SUCCESS) {
//                textToSpeech?.language = Locale.JAPANESE
//            }
//        }
//    }
//
//    // 早口で話す
//    fun speakFast(text: String, language: Locale = Locale.JAPAN) {
//        textToSpeech?.language = language
//        textToSpeech?.setSpeechRate(2.0f) // Max speed depends on the device
//        speak(text)
//    }
//
//    // ゆっくり話す
//    fun speakSlow(text: String, language: Locale = Locale.JAPAN) {
//        textToSpeech?.language = language
//        textToSpeech?.setSpeechRate(0.5f)
//        speak(text)
//    }
//
//    // 高いピッチで話す
//    fun speakHighPitch(text: String, language: Locale = Locale.JAPAN) {
//        textToSpeech?.language = language
//        textToSpeech?.setPitch(2.0f)
//        speak(text)
//    }
//
//    // 低いピッチで話す
//    fun speakLowPitch(text: String, language: Locale = Locale.JAPAN) {
//        textToSpeech?.language = language
//        textToSpeech?.setPitch(0.5f)
//        speak(text)
//    }
//
//    // 通常の話し方
//    fun speakNormal(text: String, language: Locale = Locale.JAPAN) {
//        textToSpeech?.language = language
//        textToSpeech?.setPitch(1.0f)
//        textToSpeech?.setSpeechRate(1.0f)
//        speak(text)
//    }
//
//    private fun speak(text: String) {
//        textToSpeech?.speak(text, TextToSpeech.QUEUE_FLUSH, null, null)
//    }
//
//    fun shutdown() {
//        textToSpeech?.stop()
//        textToSpeech?.shutdown()
//    }
//}