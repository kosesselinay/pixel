import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel/chat_screen.dart';
import 'package:pixel/settings.dart';
import 'package:pixel/utils/delayed_animation.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String imageUrl1 =
      'https://thumbs.dreamstime.com/b/robot-artist-studio-next-to-his-easel-painting-paints-working-neural-network-ai-generated-art-digitally-image-not-264076031.jpg'; // Replace with the URL of your first image
  String imageUrl2 =
      'https://uploads-ssl.webflow.com/5fb39592cb1bfc03c9f9b6d2/6324651df2ebb755dd57f757_COBE_Midjourney-Article-pink-elephant.jpg'; // Replace with the URL of your second image
  late String currentImage;
  @override
  void initState() {
    currentImage = imageUrl1;
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        currentImage = imageUrl2;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: 15,
                  color: Color.fromARGB(255, 255, 235, 255),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.search,
                  color: Color.fromARGB(255, 255, 235, 255),
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                  color: Color.fromARGB(255, 255, 235, 255),
                ),
                label: 'Profile',
              ),
            ]),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "Pixel",
                style: GoogleFonts.audiowide(color: Colors.white),
              ),
              pinned: false,
              elevation: 2,
              floating: false,
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              expandedHeight: MediaQuery.of(context).size.height / 2,
              flexibleSpace: Center(
                child: SingleChildScrollView(
                  child: WidgetCircularAnimator(
                    innerAnimation: Curves.easeInToLinear,
                    innerColor: Colors.white,
                    outerColor: Color.fromARGB(255, 240, 3, 19),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen())),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.network(
                                  'https://assets4.lottiefiles.com/packages/lf20_SI8fvW.json',
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tap to chat",
                                  textScaleFactor: 2,
                                  style: GoogleFonts.orbitron(
                                      fontSize: 8,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                ),
                              ],
                            ),
                            SpinKitThreeBounce(
                              color: Color.fromARGB(255, 250, 13, 13),
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Explore",
                        style: GoogleFonts.audiowide(color: Colors.white),
                        textScaleFactor: 1.5,
                      ),
                    ),
                    buildGeneratedImageRow(context),
                    buildExplorableItem(context),
                    buildExplorableItem(context),
                    buildExplorableItem(context),
                    buildExplorableItem(context),
                  ],
                )
              ]),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  Row buildGeneratedImageRow(BuildContext context) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: Duration(seconds: 2), // Duration of the animation
          child: Container(
            key: ValueKey<String>(currentImage),
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 88, 88, 88), BlendMode.overlay),
                child: FadeInImage(
                  placeholder: AssetImage(
                      'assets/placeholder.png'), // Replace with your placeholder image
                  image: NetworkImage(currentImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildExplorableItem(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 2,
          child: Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 56, 55, 55),
            ),
          )),
        ),
        Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 2,
          child: Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 56, 55, 55),
            ),
          )),
        )
      ],
    );
  }

  Widget _buildCircularIcon(IconData iconData, String label, Function onTap) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Icon(
              iconData,
              color: Colors.red,
              size: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: GoogleFonts.audiowide(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
