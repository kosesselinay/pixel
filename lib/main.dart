import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'welcome.dart'; // Import the welcome.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _currentPageIndex = 0;
  List<String> titles = [
    'Welcome to the Future of Communication',
    'AI-Powered Art & Chat: Unlock Your Imagination',
    'AI Meets Creativity: Explore the Possibilities'
  ];
  List<String> subtitles = [
    'Get instant assistants and personalized communication with our AI-powered chatbot',
    '"Unlock your creative potential with the help of our AI-Powered art and chat app"',
    '"Unlock the full potential of AI-generated art and conversation with our app"'
  ];
  List<String> animationUrls = [
    'https://assets3.lottiefiles.com/private_files/lf30_ssm93drs.json',
    'https://assets3.lottiefiles.com/private_files/lf30_ssm93drs.json',
    'https://assets3.lottiefiles.com/private_files/lf30_ssm93drs.json'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Lottie.network(animationUrls[_currentPageIndex]),
            ),
            Text(
              titles[_currentPageIndex],
              textAlign: TextAlign.center,
              style: GoogleFonts.orbitron(
                textStyle: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 227, 222, 222),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                subtitles[_currentPageIndex],
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 227, 222, 222),
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < titles.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 10,
                      width: _currentPageIndex == i ? 16 : 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentPageIndex == i ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: RawMaterialButton(
                onPressed: () {
                  if (_currentPageIndex < titles.length - 1) {
                    setState(() {
                      _currentPageIndex++;
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 2.0,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    _currentPageIndex == titles.length - 1 ? 'Done' : 'Next',
                    style: GoogleFonts.orbitron(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
          ],
        ),
      ),
    );
  }
}
