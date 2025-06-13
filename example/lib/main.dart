import 'package:flutter/material.dart';
import 'dart:async';
import 'package:papagaio_tts/papagaio_tts.dart';

void main() {
  runApp(const MyApp());
}

const defaultLang = Locale("en", "US");
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _voices = [];
  List<Locale> _languages = [];
  final _papagaioTtsPlugin = PapagaioTts();
  bool _isSpeaking = false;

  Locale _currentLanguage = defaultLang;
  String _currentVoice = "";
  double _rate = 0.5;
  double _volume = 1.0;
  double _pitch = 0.5;

  late String _phrase;

  @override
  void initState() {
    super.initState();
    getConfigurations();
  }

  Future<void> checkSpeakingStatus() async {
    Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      bool status = await getSpeakingStatus();
      if (!status) {
        timer.cancel();
      }
    });
  }

  Future<void> getConfigurations() async {
    List<String> voices = await _papagaioTtsPlugin.getVoices();
    List<Locale> languages = await _papagaioTtsPlugin.getAvailableLanguages(<String>["en", "ja"]);
    print("languages $languages");

    Locale currentLanguage = await _papagaioTtsPlugin.getLanguage();
    print("currentLanguage $currentLanguage");
    String currentVoice = await _papagaioTtsPlugin.getVoice();
    double rate = await _papagaioTtsPlugin.getRate() as double;
    double volume = await _papagaioTtsPlugin.getVolume() as double;
    double pitch = await _papagaioTtsPlugin.getPitch() as double;

    setState(() {
      _voices = voices;
      _languages = languages;
      _currentLanguage = currentLanguage;
      _currentVoice = currentVoice;
      _rate = rate;
      _volume = volume;
      _pitch = pitch;
      _phrase = "Hello, this is test of speaking status. ";
    });
  }

  Future<void> speak(String text) async {
    checkSpeakingStatus();
    await _papagaioTtsPlugin.speak(text);
  }

  Future<void> stop() async {
    await _papagaioTtsPlugin.stop();
  }

  Future<bool> getSpeakingStatus() async {
    bool isSpeaking = await _papagaioTtsPlugin.getSpeakingStatus();
    setState(() {
      _isSpeaking = isSpeaking;
    });
    return isSpeaking;
  }

  void onVoiceSelected(String voiceName) {
    _papagaioTtsPlugin.setVoice(voiceName);
  }

  Future<void> onLanguageSelected(Locale language) async {
    await _papagaioTtsPlugin.setLanguage(language);
    String currentVoice = await _papagaioTtsPlugin.getVoice();
    List<String> voices = await _papagaioTtsPlugin.getVoices();
    setState(() {
      _voices = voices;
      _currentVoice = currentVoice;
      _phrase = language.languageCode == "en"
          ? "Hello, this is test of speaking status. "
          : "こんにちは。こちらはスピーキングのテストです。";
    });
    // voices.forEach((element) {print("voice $element.name");});
  }

  void onChangeRate(num rate) {
    _papagaioTtsPlugin.setRate(rate);
  }

  void onVolumeChanged(num volume) {
    _papagaioTtsPlugin.setVolume(volume);
  }

  void onPitchSelected(num pitch) {
    _papagaioTtsPlugin.setPitch(pitch);
  }

  void changeVolume(double changeValue) {
    double after = double.parse((_volume + changeValue).toStringAsFixed(1));
    if (after < 0) {
      after = 0.0;
    } else if (after > 1.0) {
      after = 1.0;
    }
    setState(() {
      _volume = after;
    });
    _papagaioTtsPlugin.setVolume(after);
  }

  void changeRate(double changeValue) {
    double after = double.parse((_rate + changeValue).toStringAsFixed(1));
    if (after < 0) {
      after = 0.0;
    } else if (after > 1.0) {
      after = 1.0;
    }
    setState(() {
      _rate = after;
    });
    _papagaioTtsPlugin.setRate(after);
  }

  void changePitch(double changeValue) {
    double after = double.parse((_pitch + changeValue).toStringAsFixed(1));
    if (after < 0) {
      after = 0.0;
    } else if (after > 1.0) {
      after = 1.0;
    }
    setState(() {
      _pitch = after;
    });
    _papagaioTtsPlugin.setPitch(after);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<DropdownMenuEntry<String>> voicesEntry =
        _voices.map((v) => DropdownMenuEntry(value: v, label: v)).toList();

    List<DropdownMenuEntry<Locale>> languagesEntry = _languages.map((locale) => DropdownMenuEntry(value: locale, label: "$locale")).toList();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: (_currentVoice.isEmpty || _isSpeaking)
                            ? null
                            : () => speak(_phrase),
                        child: const Text("Speak",
                            style: TextStyle(fontSize: 20))),
                    ElevatedButton(
                        style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: _isSpeaking ? () => stop() : null,
                        child:
                            const Text("Stop", style: TextStyle(fontSize: 20))),
                  ]),
              Text(
                _isSpeaking ? "Speaking" : "Waiting to speak",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              const Text("Configuration"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width / 3, child: const Text("Language")),
                    DropdownMenu<Locale>(
                        width: width / 3,
                        menuHeight: height / 2,
                        enableFilter: false,
                        initialSelection: _currentLanguage,
                        dropdownMenuEntries: languagesEntry,
                        onSelected: (locale) {
                          onLanguageSelected(locale ?? defaultLang);
                        }),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width / 3, child: const Text("Voice")),
                    DropdownMenu<String>(
                        width: width / 3,
                        menuHeight: height / 2,
                        enableFilter: true,
                        initialSelection: _currentVoice,
                        dropdownMenuEntries: voicesEntry,
                        onSelected: (str) {
                          onVoiceSelected(str ?? "");
                        }),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width / 3, child: const Text("Speed")),
                    IconButton(
                        onPressed: _rate > 0.1 ? () => changeRate(-0.1) : null,
                        icon: const Icon(Icons.arrow_left)),
                    Text("$_rate"),
                    IconButton(
                        onPressed: () => _rate < 1.0 ? changeRate(0.1) : null,
                        icon: const Icon(Icons.arrow_right))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width / 3, child: const Text("Volume")),
                    IconButton(
                        onPressed: _volume > 0 ? () => changeVolume(-0.1) : null,
                        icon: const Icon(Icons.arrow_left)),
                    Text("$_volume"),
                    IconButton(
                        onPressed: _volume < 1.0 ? () => changeVolume(0.1) : null,
                        icon: const Icon(Icons.arrow_right))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width / 3, child: const Text("Pitch")),
                    IconButton(
                        onPressed: () => _pitch > 0.1 ? changePitch(-0.1) : null,
                        icon: const Icon(Icons.arrow_left)),
                    Text("$_pitch"),
                    IconButton(
                        onPressed: () => _pitch < 1.0 ? changePitch(0.1) : null,
                        icon: const Icon(Icons.arrow_right))
                  ]),
            ])),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _papagaioTtsPlugin.stop();
    _papagaioTtsPlugin.shutdown();
  }
}

// TODO タイマーの開始タイミングを、喋り始めてからにする。喋り終わったら止める OK
// メソッドコールが連続して起こらないようにする OK
// 面倒だけど、利用可能言語のリストも作る OK
// shutdownも体裁を整えて、IOS側にも作る OK
// IOS側に追加機能を実装する OK
// TESTをかく TODO Unit Testがコケる
// 初期設定のボイス名の取り方を工夫する OK]
// IOSはen-USでAndroidはen_USなので、変換するメソッドを共通部分につける　画面上はen-USで統一 仕掛かり IOS
// なぜか初期値の言語がセットされない -> 持ち越し