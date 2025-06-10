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
            }
        }
    }

    fun speak(text: String, volume: Float): Boolean {
        println("speak")

        println("voice ${textToSpeech.voice}")
        println("language ${getLanguage()}")
        println("engine ${textToSpeech.engines}")
        // TODO test

        val params = Bundle()
        params.putFloat(TextToSpeech.Engine.KEY_PARAM_VOLUME, volume)
        val result = textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, params, "")
        return result == TextToSpeech.SUCCESS
    }

    fun getAvailableLanguages(filterLanguages: List<String>): List<String> {
        println("getAvailableLanguages language ${textToSpeech.availableLanguages.toList()[0]}")

        val allLanguages = textToSpeech.availableLanguages.map {it.toString()}.toList()
        if (filterLanguages.isEmpty()) {
            return allLanguages
        }

        return filterLanguages.filter { allLanguages.contains( it ) }.toList()
    }

    fun getVoices(): List<String> {
        // TODO

//        println("voices initial ${textToSpeech.voices}")
//        return listOf("en-AU-language")
//        return listOf("Samantha").toList()
        val lang: String = getLanguage()
//        println("lang $lang")
//        if (lang.isEmpty()) {
//            setLanguage(Locale.ENGLISH.language)
//        }
        val voices: Set<Voice> = textToSpeech.voices

        val voiceNames: List<String> =
            voices.filter { it.locale.toString().startsWith(lang) }.map<Voice, String> { it.name }
                .toList()
        return voiceNames ?: emptyList()
    }

    fun getVoice(): String {
        val currentVoice = textToSpeech.voice
        print("currentVoice $currentVoice")
        if (currentVoice != null) {
            return currentVoice.name
        }
        return textToSpeech.defaultVoice.name ?: ""
    }

    fun getLanguage(): String {
        // println("lang ${Locale.ENGLISH.toString()}")
        if(textToSpeech.voice != null) {
            return textToSpeech.voice.locale.language
        }
        return Locale.ENGLISH.language
        //return Locale.ENGLISH.toString()
    }

    fun getSpeakingStatus(): Boolean {
        return textToSpeech.isSpeaking
    }

//    fun getRate(): Float {
//        return this.rate
//    }
//
//    fun getPitch(): Float {
//        return 0.5f
//    }
//    fun getVolume(): Float {
//        return 1.0f
//    }

    fun setVoice(voiceName: String): Boolean {
        val voice: Voice = textToSpeech.voices.filter { it.name == voiceName }[0]
        val result = textToSpeech.setVoice(voice)
        return result == TextToSpeech.SUCCESS
    }

    fun setLanguage(language: String): Boolean {
//        val availableLang = textToSpeech.availableLanguages;
//        println("availableLang ${availableLang}")
//        val locale: Locale = availableLang.filter { it.toLanguageTag() == language }[0]
//        println("locale ${locale}")

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
        val result = textToSpeech.setSpeechRate(rate)
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