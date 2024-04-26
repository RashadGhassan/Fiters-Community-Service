// import 'dart:html';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:community_service/screens/signInScreen.dart';
import 'package:page_transition/page_transition.dart';

class MySplash extends StatelessWidget {
  const MySplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Column(
          children: [
            SizedBox(
              width: 350,
              child: Image.asset('assets/images/ASU_Logo.png'),
            ),
          ],
        ),
        nextScreen: const SignIn(),
        splashIconSize: 250,
        duration: 4000,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
      ),
    );
  }
}
