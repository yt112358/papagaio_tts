import SwiftUI
import AVFoundation

// @MainActor
class PapagaioTts: NSObject, ObservableObject{
    static let instance: PapagaioTts = PapagaioTts()
    private var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    var voice: AVSpeechSynthesisVoice?

    @Published var isSpeaking: Bool = false
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(text: String) {
        synthesizer.stopSpeaking(at: .immediate)

        if (voice == nil) {
            voice =  AVSpeechSynthesisVoice.init(language: "en-US")
        } 
        print("#### voice \(voice)")
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = voice! as AVSpeechSynthesisVoice
        speechUtterance.rate = 0.5
        speechUtterance.volume = 1.0
        speechUtterance.pitchMultiplier = 0.5
        synthesizer.speak(speechUtterance)
    }

    func getVoices()-> [String] {
        print("getVoices swift")
        let currentVoice: AVSpeechSynthesisVoice? = AVSpeechSynthesisVoice.init(language: "en-US")  // TODO
        self.voice = currentVoice
        speak(text: "Test")
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let list: [String] = voices.map { $0.name }

        return list
    }

    func setVoice(_ voice: String) {
        if let selectedVoice: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice.speechVoices().first(where: { $0.name == voice}) {
            self.voice = selectedVoice
        }
    }

    func getSpeakingStatus() -> Bool {
        print("isSpeaking \(isSpeaking)")
        return self.isSpeaking
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
