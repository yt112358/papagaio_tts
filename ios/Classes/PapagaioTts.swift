import SwiftUI
import AVFoundation

class PapagaioTts: NSObject, ObservableObject{
    static let instance: PapagaioTts = PapagaioTts()
    var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    var voice: AVSpeechSynthesisVoice?
    var rate: Float?
    var language: String?
    var volume: Float?
    var pitch: Float?

    @Published var isSpeaking: Bool = false
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(_ text: String) {
        synthesizer.stopSpeaking(at: .immediate)
        
        if (language == nil) {
            language = "en-US"
        }
        if (voice == nil) {
            voice =  AVSpeechSynthesisVoice.init(language: language)
        }
        if (volume == nil) {
            volume = 1.0
        }
        if (rate == nil) {
            rate = 0.5
        }
        if (pitch == nil) {
            pitch = 0.5
        }
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = voice! as AVSpeechSynthesisVoice
        speechUtterance.rate = rate! as Float
        speechUtterance.volume = self.volume! as Float
        speechUtterance.pitchMultiplier = pitch! as Float
        synthesizer.speak(speechUtterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    private func splitLocale(_ locale: String) -> [String] {
        let substring = locale.split(separator: "-")
        return [String(substring[0]), String(substring[1])]
    }

    func getAvailableLanguages(_ filter:[String])-> [[String]] {    // ex return: [[en, US], [ja, JP], [en, null]]
        let voices: [AVSpeechSynthesisVoice] = AVSpeechSynthesisVoice.speechVoices()
        let languages: [String] = [String](Set(voices.map { $0.language}))
        let langCountries: [[String]] = languages.map { splitLocale($0) }
        if (filter.isEmpty) {
            return langCountries
        }

        return langCountries.filter { filter.contains($0[0]) }
    }

    func getVoices()-> [String] {
        let voices: [AVSpeechSynthesisVoice] = AVSpeechSynthesisVoice.speechVoices()
        let list: [String] = voices.filter { $0.language == language } .map { $0.name }
        return list
    }

    func getSpeakingStatus() -> Bool {
        return self.isSpeaking
    }

    func getLanguage() -> String {
        return self.language ?? "en-US"
    }
    func getVoice() -> String {
        return self.voice?.name ?? ""
    }
    func getRate() -> Float {
        return self.rate ?? 0.5 as Float
    }
    func getVolume() -> Float {
        return self.volume ?? 1.0 as Float
    }
    func getPitch() -> Float {
        return self.pitch ?? 0.5 as Float
    }

    func setVoice(_ voice: String){
        if let selectedVoice: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice.speechVoices().first(where: { $0.name == voice}) {
            self.voice = selectedVoice
        }
    }

    func setRate(_ rate: Float) {
        self.rate = rate
    }

    func setLanguage(_ language: String){
        print("language \(language)")
        self.language = language
        self.voice = AVSpeechSynthesisVoice.init(language: language)
    }

    func setVolume(_ volume: Float) {
        self.volume = volume
    }

    func setPitch(_ pitch: Float){
        self.pitch = pitch
    }
}

extension PapagaioTts: AVSpeechSynthesizerDelegate {
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        Task {
            self.isSpeaking = true
        }
    }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task {
            self.isSpeaking = false
        }
    }
    
    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task {
            self.isSpeaking = false
        }
     }
}
