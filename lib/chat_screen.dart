import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixel/utils/delayed_animation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'API/api_interface.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _volumeUp = true;
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText speech = stt.SpeechToText();
  late final _spinkit;
  bool _isListening = false;
  String currentLanguage = "TR";

  final List<Message> _messages = List.empty(growable: true);
  @override
  void initState() {
    _getPermissions();
    _spinkit = const SpinKitRipple(
      color: Color.fromARGB(255, 226, 29, 29),
      size: 20.0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage(currentLanguage == "TR" ? "tr-TR" : "en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    currentLanguage == "TR"
        ? await flutterTts.setSpeechRate(0.9)
        : await flutterTts.setSpeechRate(0.5);
  }

  void _handleMicMessage() async {
    setState(() => _isListening = true);
    bool available = await speech.initialize();
    if (available) {
      List<stt.LocaleName> locales = await speech.locales();

      speech.listen(
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 10),
        listenMode: stt.ListenMode.dictation,
        partialResults: false,
        localeId: currentLanguage == "TR" ? locales[0].localeId : "English",
        onResult: (result) {
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _isListening = false;
              _textController.text += result.recognizedWords;
              _textController.text += " ";
            });
          });
        },
      );
    }
  }

  void _handleSendMessage() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty) {
      print(text);
      if (text.toLowerCase() == "Let's speak Turkish".toLowerCase() ||
          text.toLowerCase() == "İngilizce konuşalım".toLowerCase()) {
        setState(() {
          if (text.toLowerCase() == "İngilizce konuşalım".toLowerCase()) {
            currentLanguage = "EN";
          } else if (text.toLowerCase() ==
              "Let's speak Turkish".toLowerCase()) {
            currentLanguage = "TR";
          }
        });
        _speak(currentLanguage == "TR"
            ? "Artık seninle Türkçe konuşacağım."
            : "Language changed to English.");
        _textController.clear();
        return;
      }
      HttpService().sendPostRequest(text).then((value) async {
        final bool messageAddedToPool = await _handleReceiveMessage(value);
        if (messageAddedToPool) _speak(value);
      });

      setState(() {
        _messages.add(Message(sender: 'Berkay', text: text));
        Future.delayed(
            const Duration(seconds: 1),
            () => _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent));
        FocusScope.of(context).unfocus();
      });
      _textController.clear();
    }
  }

  Future<bool> _handleReceiveMessage(String responseText) {
    final String text = responseText.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(sender: 'Pixel', text: text));
        Future.delayed(
            const Duration(seconds: 1),
            () => _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent));
      });

      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<void> _getPermissions() async {
    final PermissionStatus permissionStatus =
        await Permission.microphone.request();
    if (permissionStatus != PermissionStatus.granted) {
      throw Exception('Microphone permission not granted.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () async {
                  if (_volumeUp) {
                    flutterTts
                        .setVolume(0)
                        .then((value) => setState(() => _volumeUp = false));
                  } else {
                    flutterTts.setVolume(1).then((value) => setState(() {
                          _volumeUp = true;
                        }));
                  }
                },
                child: Icon(
                    _volumeUp
                        ? Icons.volume_up_outlined
                        : Icons.volume_off_outlined,
                    color: Color.fromARGB(255, 255, 255, 255))),
            SizedBox(width: 10)
          ],
          backgroundColor: Colors.black,
          elevation: 2.0,
          title: AnimatedTextKit(
            totalRepeatCount: 2,
            repeatForever: false,
            animatedTexts: [
              TyperAnimatedText(
                'Pixel',
                speed: Duration(milliseconds: 100),
                textStyle: GoogleFonts.orbitron(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 88, 35, 35),
        body: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 8, 0, 0)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: _messages.isNotEmpty
                      ? ListView.builder(
                          controller: _scrollController,
                          itemCount: _messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            final message = _messages[index];
                            final isSentMessage = message.sender == 'Berkay';

                            return Align(
                              alignment: isSentMessage
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: DelayedAnimation(
                                curve: Curves.easeIn,
                                delay: 100,
                                offset:
                                    Offset((isSentMessage ? 0.35 : -0.35), 0.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                    color: isSentMessage
                                        ? Color.fromARGB(255, 204, 37, 37)
                                        : Color.fromARGB(255, 43, 42, 42),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            message.sender,
                                            style: GoogleFonts.audiowide(
                                              fontWeight: FontWeight.bold,
                                              color: isSentMessage
                                                  ? Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  : Color.fromARGB(
                                                      255, 255, 255, 255),
                                            ),
                                          ),
                                          Icon(
                                            Icons.copy,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        message.text,
                                        style: GoogleFonts.audiowide(
                                            fontSize: 12.0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DelayedAnimation(
                                curve: Curves.easeIn,
                                delay: 100,
                                offset: const Offset(0.0, 0.35),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Pixel",
                                        textScaleFactor: 2,
                                        style: GoogleFonts.orbitron(
                                            fontSize: 14, color: Colors.white)),
                                    Lottie.network(
                                        'https://assets4.lottiefiles.com/packages/lf20_SI8fvW.json',
                                        fit: BoxFit.contain,
                                        width: 50,
                                        height: 50),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: _buildTextComposer(context),
                ),
              ],
            )));
  }

  Widget _buildTextComposer(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
                height: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: !_isListening
                    ? TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 5,
                        cursorColor: Color.fromARGB(255, 235, 37, 37),
                        style: GoogleFonts.nunitoSans(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                        controller: _textController,
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.nunito(
                              color: Colors.white24, fontSize: 8),
                          hintText: "Ask anything",
                          label: Text("Pixel is ready to assist ..",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.orbitron(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 10)),
                          border: InputBorder.none,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Text("Pixel is listening..",
                                style: GoogleFonts.audiowide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 10)),
                            _spinkit
                          ])),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            height: double.maxFinite,
            width: 50,
            decoration: BoxDecoration(
                color: !_isListening
                    ? Color.fromARGB(255, 204, 37, 37)
                    : const Color.fromARGB(255, 56, 56, 56),
                borderRadius: BorderRadius.circular(5)),
            child: InkWell(
              onTap: () => _handleMicMessage(),
              child: const Icon(
                Icons.mic,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            height: double.maxFinite,
            width: 50,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 204, 37, 37),
                borderRadius: BorderRadius.circular(5)),
            child: InkWell(
              onTap: () => _handleSendMessage(),
              child: const Icon(
                Icons.send,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}
