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
    case "getVoices":
      result(getVoices())
    case "speak":
      let text = call.arguments as! String
      print("#### text \(text)")
      speak(text)
    case "getSpeakingStatus":
      result(getSpeakingStatus())
    case "setVoice":
      let voice = call.arguments as! String
      setVoice(voice)
    case "setRate":
      let rate = (call.arguments as! NSNumber).floatValue
      setRate(rate)
    case "setLanguage":
      let language = call.arguments as! String
      setLanuguage(language)
    case "setVolume":
      let volume = (call.arguments as! NSNumber).floatValue
      print("### pluginsetVolume \(volume)")
      setVolume(volume)
    case "setPitch":
      let pitch = (call.arguments as! NSNumber).floatValue
      setPitch(pitch)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func getVoices() -> [String] {
      return tts.getVoices()
  }

  func speak(_ text: String) {
    return tts.speak(text)
  }

  func getSpeakingStatus() -> Bool {
    return tts.getSpeakingStatus()
  }

  func setVoice(_ voice: String) {
    return tts.setVoice(voice)
  }

  func setRate(_ rate: Float) {
    return tts.setRate(rate)
  }

  func setLanuguage(_ language: String) {
    return tts.setLanuguage(language)
  }

  func setVolume(_ volume: Float) {
    return tts.setVolume(volume)
  }

  func setPitch(_ pitch: Float) {
    return tts.setPitch(pitch)
  }
}


