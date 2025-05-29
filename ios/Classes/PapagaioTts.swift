import SwiftUI
import AVFoundation

class PapagaioTts: NSObject, ObservableObject{
    static let instance: PapagaioTts = PapagaioTts()
    private var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
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
        print("volume \(self.volume)")
        synthesizer.stopSpeaking(at: .immediate)

        print("language \(self.language)")
        
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

    func getVoices()-> [String] {
        let currentVoice: AVSpeechSynthesisVoice? = AVSpeechSynthesisVoice.init(language: "en-US")  // TODO
        self.voice = currentVoice
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let list: [String] = voices.map { $0.name }

        return list
    }

    func getSpeakingStatus() -> Bool {
        return self.isSpeaking
    }

    func setVoice(_ voice: String) {
        if let selectedVoice: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice.speechVoices().first(where: { $0.name == voice}) {
            self.voice = selectedVoice
        }
    }

    func setRate(_ rate: Float) {
        self.rate = rate
    }

    func setLanuguage(_ language: String) {
        self.language = language
    }

    func setVolume(_ volume: Float) {
        print("### setVolume")
        self.volume = volume
        print("### volume2 \(volume)")
    }

    func setPitch(_ pitch: Float) {
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
