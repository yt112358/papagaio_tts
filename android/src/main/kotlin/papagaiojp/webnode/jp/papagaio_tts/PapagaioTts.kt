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

    fun getAvailableLanguages(filterLanguages: List<String>): List<List<String>> {
        val allLanguages = textToSpeech.availableLanguages.map {it.toString().split("_")}.toList()
        if (filterLanguages.isEmpty()) {
            return allLanguages
        }

        return allLanguages.filter { filterLanguages.contains( it[0] ) }.toList()
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

    fun setLanguage(language: String, country: String): Boolean {
        val locale = Locale(language, country)
        val langLocale = Locale(language)
        if (textToSpeech.isLanguageAvailable(locale) == TextToSpeech.LANG_AVAILABLE) {
            val result = textToSpeech.setLanguage(locale)
            return result == TextToSpeech.SUCCESS
        } else if(textToSpeech.isLanguageAvailable(langLocale) == TextToSpeech.LANG_AVAILABLE) {
            val result = textToSpeech.setLanguage(langLocale)
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