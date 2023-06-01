import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel/home.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        backgroundColor: Colors.black,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Settings",
            textScaleFactor: 1,
            overflow: TextOverflow.clip,
            style: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 246, 241, 241),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  onPressed: () {
                    // "Try Premium" düğmesine tıklandığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 40, 41, 40),
                    onPrimary: Color.fromARGB(255, 195, 150, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 153, 148, 78)
                              .withOpacity(0.1),
                          border: Border.all(
                            color: Color.fromARGB(255, 248, 231, 36)
                                .withOpacity(0.001),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.crown,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Try Premium",
                          style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  onPressed: () {
                    // "Rate Us" düğmesine tıklandığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 40, 41, 40),
                    onPrimary: Color.fromARGB(255, 190, 24, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Color.fromARGB(255, 175, 91, 76).withOpacity(0.1),
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 105, 105)
                                .withOpacity(0.001),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.star,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Rate Us",
                          style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  onPressed: () {
                    // "Restore Purchases" düğmesine tıklandığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 40, 41, 40),
                    onPrimary: Color.fromARGB(255, 190, 24, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Color.fromARGB(255, 175, 91, 76).withOpacity(0.1),
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 105, 105)
                                .withOpacity(0.001),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.redo,
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Restore Purchases",
                          style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  onPressed: () {
                    // "Privacy Policy" düğmesine tıklandığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 40, 41, 40),
                    onPrimary: Color.fromARGB(255, 190, 24, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Color.fromARGB(255, 175, 91, 76).withOpacity(0.1),
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 105, 105)
                                .withOpacity(0.001),
                          ),
                        ),
                        child: Icon(
                          Icons.security,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Privacy Policy",
                          style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  onPressed: () {
                    // "Terms of Use" düğmesine tıklandığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 40, 41, 40),
                    onPrimary: Color.fromARGB(255, 190, 24, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Color.fromARGB(255, 175, 91, 76).withOpacity(0.1),
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 105, 105)
                                .withOpacity(0.001),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.fileAlt,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Terms of Use",
                          style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  onPressed: () {
                    // "Contact Us" düğmesine tıklandığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 40, 41, 40),
                    onPrimary: Color.fromARGB(255, 190, 24, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Color.fromARGB(255, 175, 91, 76).withOpacity(0.1),
                          border: Border.all(
                            color: Color.fromARGB(255, 240, 105, 105)
                                .withOpacity(0.001),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.envelope,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Contact Us",
                          style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    );
  }
}
