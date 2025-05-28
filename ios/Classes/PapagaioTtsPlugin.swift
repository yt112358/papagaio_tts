import Flutter
import UIKit

public class PapagaioTtsPlugin: NSObject, FlutterPlugin {
  let demo = PapagaioTts()
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "papagaio_tts", binaryMessenger: registrar.messenger())
    let instance = PapagaioTtsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getVoices":
      result(getVoices())
    case "setVoice":
      let voice = call.arguments as! String
      setVoice(voice)
    case "speak":
      let text = call.arguments as! String
      print("#### text \(text)")
      speak(text)
    case "getSpeakingStatus":
      result(getSpeakingStatus())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func getVoices() -> [String] {
      return demo.getVoices()
  }
  func setVoice(_ voice: String) {
    return demo.setVoice(voice)
  }

  func speak(_ text: String) {
    return demo.speak(text: text)
  }

  func getSpeakingStatus() -> Bool {
    return demo.getSpeakingStatus()
  }
}


