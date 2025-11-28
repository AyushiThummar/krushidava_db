import 'dart:async';
import 'package:flutter/material.dart';
import 'package:krushidava/login_screen.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to next screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Register()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xFF63D3B7),
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: const Color(0xFFE1FCF9))),

            // Center column for logo + text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                    decoration: const ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.cover,
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                  const SizedBox(height: 20), // space between logo and text
                  // App name + tagline
                  Column(
                    children: const [
                      Text(
                        'Krushi Dava',
                        style: TextStyle(
                          color: Color(0xFF064E3C),
                          fontSize: 42,
                          fontFamily: 'Merienda One',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8), // small gap between name and tagline
                      Text(
                        'Your crops, our care!!',
                        style: TextStyle(
                          color: Color(0xFF064E3C),
                          fontSize: 22,
                          fontFamily: 'Crimson Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example home screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to Home!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
