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
            } else {
                println("ERROR: status = $status")
                throw Exception("Failure with initialize")
            }
        }
    }

    fun speak(text: String, volume: Float): Boolean {
        val params = Bundle()
        params.putFloat(TextToSpeech.Engine.KEY_PARAM_VOLUME, volume)
        val result = textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, params, "")
        return result == TextToSpeech.SUCCESS
    }

    fun getAvailableLanguages(filterLanguages: List<String>): List<String> {
        val allLanguages = textToSpeech.availableLanguages.map {it.toString()}.toList()
        if (filterLanguages.isEmpty()) {
            return allLanguages
        }

        return filterLanguages.filter { allLanguages.contains( it ) }.toList()
    }

    fun getVoices(): List<String> {
        val lang: String = getLanguage()
        val voices: Set<Voice> = textToSpeech.voices

        return voices.filter { it.locale.toString().startsWith(lang) }.map { it.name }
            .toList()
    }

    fun getVoice(): String {
        val currentVoice = textToSpeech.voice
        if (currentVoice != null) {
            return currentVoice.name
        }
        return textToSpeech.defaultVoice.name ?: ""
    }

    fun getLanguage(): String {
        if(textToSpeech.voice != null) {
            return textToSpeech.voice.locale.toString()
        }
        return Locale.ENGLISH.toString()
    }

    fun getSpeakingStatus(): Boolean {
        return textToSpeech.isSpeaking
    }

    fun setVoice(voiceName: String): Boolean {
        val voice: Voice = textToSpeech.voices.filter { it.name == voiceName }[0]
        val result = textToSpeech.setVoice(voice)
        return result == TextToSpeech.SUCCESS
    }

    fun setLanguage(language: String): Boolean {
        if (textToSpeech.isLanguageAvailable(Locale(language)) == TextToSpeech.LANG_AVAILABLE) {
            val result = textToSpeech.setLanguage(Locale(language))
            return result == TextToSpeech.SUCCESS
        }
        return false
    }

    fun setPitch(pitch: Float): Boolean {
        val result = textToSpeech.setPitch(pitch)
        return result == TextToSpeech.SUCCESS
    }

    fun setRate(rate: Float): Boolean {
        // Rate for Swift has limit 1.0 and Android 2.0
        val result = textToSpeech.setSpeechRate(rate * 2)
        return result == TextToSpeech.SUCCESS
    }
    fun stop(): Boolean {
        val result = textToSpeech.stop()
        return result == TextToSpeech.SUCCESS
    }

    fun shutdown() {
       textToSpeech.shutdown()
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

//}