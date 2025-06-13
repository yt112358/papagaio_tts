import Flutter
import UIKit
import AVFoundation

public class PapagaioTtsPlugin: NSObject, FlutterPlugin {
  let tts = PapagaioTts()
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "papagaio_tts", binaryMessenger: registrar.messenger())
    let instance = PapagaioTtsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getAvailableLanguages":
      // TODO
      let filter = call.arguments as! [String]
      let convertedFilter = filter.map { $0.replacingOccurrences(of: "_", with: "-", options: .literal, range: nil) }
      result(getAvailableLanguages(convertedFilter))
    case "getVoices":
      result(getVoices())
    case "speak":
      let text = call.arguments as! String
      speak(text)
    case "stop":
      stop()
    case "shutdown":
      stop()
    case "getSpeakingStatus":
      result(getSpeakingStatus())

    // Getters
    case "getLanguage":
      result(getLanguage())
    case "getVoice":
      result(getVoice())
    case "getRate":
      result(getRate())
    case "getVolume":
      result(getVolume())
    case "getPitch":
      result(getPitch())

    // Setters
    case "setVoice":
      let voice = call.arguments as! String
      setVoice(voice)
        result(true)
    case "setRate":
      let rate = (call.arguments as! NSNumber).floatValue
      setRate(rate)
        result(true)
    case "setLanguage":
      let language = call.arguments as! [String]
      setLanguage(language)
      result(true)
    case "setVolume":
      let volume = (call.arguments as! NSNumber).floatValue
      print("### pluginsetVolume \(volume)")
      setVolume(volume)
        result(true)
    case "setPitch":
      let pitch = (call.arguments as! NSNumber).floatValue
      setPitch(pitch)
        result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func getAvailableLanguages(_ filter: [String]) -> [[String]] {
    // TODO
    return tts.getAvailableLanguages(filter)
  }

  func getVoices() -> [String] {
      return tts.getVoices()
  }

  func speak(_ text: String) {
    return tts.speak(text)
  }

  func stop() {
    return tts.stop()
  }

  func getSpeakingStatus() -> Bool {
    return tts.getSpeakingStatus()
  }

  func getVoice() -> String {
    return tts.getVoice()
  }

  func getLanguage() -> String {
    return tts.getLanguage()
  }

  func getRate() -> Float {
    return tts.getRate()
  }

    func getVolume() -> Float {
    return tts.getVolume()
  }

  func getPitch() -> Float {
    return tts.getPitch()
  }


  func setVoice(_ voice: String) {
    return tts.setVoice(voice)
  }

  func setRate(_ rate: Float){
    return tts.setRate(rate)
  }

  func setLanguage(_ language: [String]) {
    if (language.count == 2) {
      return tts.setLanguage("\(language[0])-\(language[1])")
    }
    return tts.setLanguage("\(language[0]))")
  }

  func setVolume(_ volume: Float) {
    return tts.setVolume(volume)
  }

  func setPitch(_ pitch: Float) {
    return tts.setPitch(pitch)
  }
}


