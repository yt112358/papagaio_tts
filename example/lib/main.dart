import 'package:flutter/material.dart';
import 'dart:async';
import 'package:papagaio_tts/papagaio_tts.dart';
import 'dart:ffi';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _voices = [];
  final _papagaioTtsPlugin = PapagaioTts();
  bool _isSpeaking = false;

  double _rate = 0.5;
  double _volume = 1.0;
  double _pitch = 0.5;

  @override
  void initState() {
    super.initState();
    getVoiceOptions();
    checkSpeakingStatus();
  }

  Future<void> checkSpeakingStatus() async {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      getSpeakingStatus();
    });
  }

  Future<void> getVoiceOptions() async {
    List<String> voices = await _papagaioTtsPlugin.getVoices();

    setState(() {
      _voices = voices;
    });
  }

  Future<void> speak(String text) async {
    await _papagaioTtsPlugin.speak(text);
  }

  Future<void> getSpeakingStatus() async {
    bool isSpeaking = await _papagaioTtsPlugin.getSpeakingStatus();
    setState(() {
      _isSpeaking = isSpeaking;
    });
  }

  void onVoiceSelected(String voiceName) {
    _papagaioTtsPlugin.setVoice(voiceName);
  }

  Future<void> onLanguageSelected(String language) async {
    await _papagaioTtsPlugin.setLanguage(language);
    List<String> voices = await _papagaioTtsPlugin.getVoices();
    setState(() {
      _voices = voices;
    });
    voices.forEach((element) {print("voice $element.name");});
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

  void setVolume(double changeValue) {
    double after = double.parse((_volume + changeValue).toStringAsFixed(1));
    if(after < 0) {
      after = 0.0;
    } else if(after > 1.0) {
      after = 1.0;
    }
    setState(() {
      _volume = after;
    });
    _papagaioTtsPlugin.setVolume(after);
  }

  void setRate(double changeValue) {
    double after = double.parse((_rate + changeValue).toStringAsFixed(1));
    if(after < 0) {
      after = 0.0;
    } else if(after > 1.0) {
      after = 1.0;
    }
    setState(() {
      _rate = after;
    });
    _papagaioTtsPlugin.setRate(after);
  }

  void setPitch(double changeValue) {
    double after = double.parse((_pitch + changeValue).toStringAsFixed(1));
    if(after < 0) {
      after = 0.0;
    } else if(after > 1.0) {
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

    List<DropdownMenuEntry<String>> entry =
        _voices.map((v) => DropdownMenuEntry(value: v, label: v)).toList();
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
              ElevatedButton(
                  style: const ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  onPressed: () =>
                      speak("Hello, this is test of speaking status. "),
                  child: const Text("Speak", style: TextStyle(fontSize: 20))),
              // ElevatedButton(onPressed: () => getSpeakingStatus(), child: Text("Get Status")),
              Text(
                _isSpeaking ? "Speaking" : "Waiting to speak",
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 50),

              const Text("Configuration"),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: width / 3, child: const Text("Language")),
              DropdownMenu<String>(
                  width: width / 3,
                  menuHeight: height / 2,
                  enableFilter: true,
                  dropdownMenuEntries: const [DropdownMenuEntry(value: "en-US", label: "English"), DropdownMenuEntry(value: "ja", label: "Japanese")],
                  onSelected: (str) {
                    onLanguageSelected(str ?? "ja-JP");
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
                  dropdownMenuEntries: entry,
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
                        onPressed: _rate > 0.2 ? () => setRate(-0.2) : null,
                        icon: Icon(Icons.arrow_left)),
                    Text("$_rate"),
                    IconButton(
                        onPressed: () => _rate < 1.0 ? setRate(0.2) : null,
                        icon: Icon(Icons.arrow_right))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width / 3, child: const Text("Volume")),
                    IconButton(
                        onPressed: _volume > 0 ? () => setVolume(-0.2) : null,
                        icon: Icon(Icons.arrow_left)),
                    Text("$_volume"),
                    IconButton(
                        onPressed: _volume < 1.0 ? () => setVolume(0.2) : null,
                        icon: Icon(Icons.arrow_right))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width / 3, child: const Text("Pitch")),
                    IconButton(
                        onPressed: () => _pitch > 0.2 ? setPitch(-0.2) : null,
                        icon: Icon(Icons.arrow_left)),
                    Text("$_pitch"),
                    IconButton(
                        onPressed: () => _pitch < 1.0 ? setPitch(0.2) : null,
                        icon: Icon(Icons.arrow_right))
                  ]),
            ])),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // TODO  終了処理
    // PapagaioTts.stop()
  }
}
