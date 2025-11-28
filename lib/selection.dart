import 'package:flutter/material.dart';
import 'package:krushidava/shopkeeper_register.dart';
import 'package:krushidava/farmer_register.dart';
import 'login_screen.dart';

class Selection extends StatelessWidget {
  const Selection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Container(
                    width: 45.78,
                    height: 35,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),

            // Title
            const Text(
              "Welcome to\nKrushi Dava",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF064E3C),
                fontSize: 32,
                fontFamily: 'Merienda One',
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 50),

            // Farmer and Shopkeeper options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    // Farmer Image
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        "assets/images/farmer.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterFarmer(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.black38,
                        elevation: 4,
                      ),
                      child: const Text(
                        "Farmer",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // Shopkeeper Image
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        "assets/images/shopkeeper.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterShopkeeper(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.black38,
                        elevation: 4,
                      ),
                      child: const Text(
                        "Shopkeeper",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
