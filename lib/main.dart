// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:krushidava/farmer_profile.dart';
// import 'package:krushidava/firebase_options.dart';
// import 'package:krushidava/home.dart';
// import 'package:krushidava/login_screen.dart';
// import 'package:krushidava/splash.dart';
// // ignore: duplicate_import
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Krushi Dava',
//       theme: ThemeData(primarySwatch: Colors.teal),

//       // Start with Splash screen
//       home: const StartingScreen(),

//       routes: {
//         '/login': (context) => Register(),
//         '/home': (context) => HomePage(),
//         '/profile': (context) => ProfilePage(),
//       },
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// import your generated firebase options file
import 'firebase_options.dart';

import 'package:krushidava/farmer_profile.dart';
import 'package:krushidava/home.dart';
import 'package:krushidava/login_screen.dart';
import 'package:krushidava/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with correct platform options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krushi Dava',
      theme: ThemeData(primarySwatch: Colors.teal),

      // Starting screen
      home: const StartingScreen(),

      routes: {
        '/login': (context) => Register(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
