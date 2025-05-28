import 'package:flutter/material.dart';
import 'dart:async';
import 'package:papagaio_tts/papagaio_tts.dart';

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
  final _papSttDemoPlugin = PapagaioTts();
  bool _isSpeaking = false;

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
    List<String> voices = await _papSttDemoPlugin.getVoices();

    setState(() {
      _voices = voices;
    });
  }

  void onVoiceSelected(String voiceName) {
    print("#### main voiceName ${voiceName}");
    _papSttDemoPlugin.setVoice(voiceName);
  }

  Future<void> speak(String text) async {
    await _papSttDemoPlugin.speak(text);
  }

  Future<void> getSpeakingStatus() async {
    bool isSpeaking = await _papSttDemoPlugin.getSpeakingStatus();
    setState(() {
      _isSpeaking = isSpeaking;
    });
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
              DropdownMenu<String>(
                  width: width - 20,
                  menuHeight: height / 2,
                  label: const Text("Voice type"),
                  enableFilter: true,
                  dropdownMenuEntries: entry,
                  onSelected: (str) {
                    onVoiceSelected(str ?? "");
                  }),
              ElevatedButton(
                  onPressed: () =>
                      speak("Hello, this is test of speaking status. "),
                  child: Text("Speak")),
              // ElevatedButton(onPressed: () => getSpeakingStatus(), child: Text("Get Status")),
              Text(
                _isSpeaking ? "Speaking" : "Waiting to speak",
                textAlign: TextAlign.center,
              )
            ])),
      ),
    );
  }
}
