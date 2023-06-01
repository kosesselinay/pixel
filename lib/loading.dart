import 'package:pixel/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  List<String> loadingTexts = [
    'Loading...',
    'Personalized...',
    'Preparing...',
    'Loading data...',
    'Loading content...',
    'Updating...',
    'Processing request...',
    'Successful!'
  ];
  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentTextIndex = (_currentTextIndex + 1) % loadingTexts.length;
            if (_currentTextIndex == loadingTexts.length - 1) {
              _showCompletionDialog();
            } else {
              _animationController?.reset();
              _animationController?.forward();
            }
          });
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            height: 400,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / 9,
                    child: SpinKitChasingDots(
                      color: Colors.red,
                    )),
                SizedBox(height: 16),
                Text(
                  "Completed!",
                  style: GoogleFonts.audiowide(
                    color: Colors.red,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                  // add margin to move text down
                ),
                SizedBox(height: 8),
                Text(
                  "Your personal assistant is ready.",
                  style: GoogleFonts.orbitron(
                    color: Color.fromARGB(255, 160, 167, 164),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                          // İlk butona tıklama işlemleri burada yapılacak
                        },
                        child: Text(
                          'LET\'S GO!',
                          style: GoogleFonts.orbitron(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Color.fromARGB(255, 40, 41, 40),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitChasingDots(
                    color: Colors.red,
                  ),
                  SizedBox(height: 10),
                  AnimatedBuilder(
                    animation: _animationController!,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _animationController!.value,
                        child: Text(
                          loadingTexts[_currentTextIndex],
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
