import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:krushidava/verification.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Back button + Title in one line
              Row(
                children: [
                  const SizedBox(width: 20), // left padding
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Register()),
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
                        shadows: [
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
                  const SizedBox(width: 40), // gap between back button & text
                  const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Illustration
              SizedBox(
                width: 300,
                height: 230,

                child: Image.asset(
                  "assets/images/forgot_password.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              // Subtitle
              const Text(
                'Enter your Mobile Number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We will send you 4 digit verification code',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              // Mobile number TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter Registered mobile no',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Generate OTP button
              SizedBox(
                width: 320,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF064E3C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    String phone = phoneController.text.trim();

                    if (phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter your mobile number"),
                          backgroundColor: Color.fromARGB(255, 131, 1, 1),
                        ),
                      );
                    } else if (phone.length != 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter a valid 10-digit mobile number",
                          ),
                          backgroundColor: Color.fromARGB(255, 131, 1, 1),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OtpLogin()),
                      );
                    }
                  },
                  child: const Text(
                    'Generate OTP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: const Center(
        child: Text('Verification Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
