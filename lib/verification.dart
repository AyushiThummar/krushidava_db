// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class OtpLogin extends StatefulWidget {
  const OtpLogin({super.key});

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _validateOtp() {
    bool hasEmpty = _otpControllers.any((c) => c.text.trim().isEmpty);

    if (hasEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all 4 digits of OTP"),
          backgroundColor: Color.fromARGB(255, 131, 1, 1),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // Back arrow
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
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

                  const SizedBox(height: 24),

                  // OTP UI card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Image.asset("assets/images/otp.png"),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Verification code',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please enter the OTP received on your mobile.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 28),

                          // OTP fields with auto move
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              4,
                              (index) => SizedBox(
                                width: 55,
                                child: TextField(
                                  controller: _otpControllers[index],
                                  focusNode: _focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    filled: true,
                                    fillColor: const Color(0xFFF9F6F6),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (v) => _onChanged(v, index),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          Text(
                            '1:59',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.3),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Color.fromARGB(255, 245, 143, 26),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Login button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 100,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF064E3C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _validateOtp,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
