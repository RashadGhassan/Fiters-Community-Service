import 'package:community_service/firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:community_service/screens/splashScreen.dart';
import 'package:community_service/screens/signInScreen.dart';
import 'package:community_service/screens/signUpScreen.dart';
import 'package:community_service/screens/signUpInfoScreen.dart';
import 'package:community_service/screens/profileScreen.dart';
import 'package:community_service/screens/editProfileScreen.dart';
import 'package:community_service/screens/homeScreen.dart';
import 'package:community_service/screens/dashScreen.dart';
import 'package:community_service/screens/createEventInfoScreen.dart';
import 'package:community_service/screens/settingsScreen.dart';
import 'package:community_service/screens/eventDescriptionScreen.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF144E73),
            ),
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: "Inter",
            ),
      ),
      title: "Community Service App",
      initialRoute: '/splashScreen',
      routes: {
        "/splashScreen": (context) => const MySplash(),
        "/signInScreen": (context) => const SignIn(),
        "/signUpScreen": (context) => const SignUp(),
        "/signUpInfoScreen": (context) => const SignUpInfo(),
        "/homeScreen": (context) => const Home(),
        "/dashScreen": (context) => const Dashboard(),
        "/createEventInfoScreen": (context) => const CompleteInfo(),
        "/profileScreen": (context) => const ProfileScreen(),
        "/settingsScreen": (context) => const Settings(),
        "/editProfileScreen": (context) => const EditProfileScreen(),
        "/eventDescriptionScreen": (context) => const EventDescription(),
      },
    );
  }
}
