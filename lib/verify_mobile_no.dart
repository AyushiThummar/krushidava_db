// import 'package:flutter/material.dart';
// // import 'package:krushidava/home.dart'; // for farmer
// // import 'package:krushidava/shopkeeper_dashboard.dart'; // for shopkeeper
// import 'login_screen.dart'; // for shopkeeper registration

// class VerifyMobileNo extends StatefulWidget {
//   final String userType; // 👈 added

//   const VerifyMobileNo({super.key, required this.userType});

//   @override
//   State<VerifyMobileNo> createState() => _VerifyMobileNoState();
// }

// class _VerifyMobileNoState extends State<VerifyMobileNo> {
//   final List<TextEditingController> _controllers = List.generate(
//     4,
//     (_) => TextEditingController(),
//   );
//   final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

//   @override
//   void dispose() {
//     for (final c in _controllers) {
//       c.dispose();
//     }
//     for (final f in _focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   void _onChanged(String value, int index) {
//     if (value.length == 1 && index < 3) {
//       _focusNodes[index + 1].requestFocus();
//     } else if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   String get otp => _controllers.map((e) => e.text).join();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//         ),
//         width: double.infinity,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 4),
//             Container(
//               width: 40,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(2.5),
//               ),
//             ),
//             const SizedBox(height: 20),

//             const Text(
//               'Detecting OTP (30s)',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),

//             const Text(
//               'We have sent a 4-digit OTP to your mobile number 96********',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),

//             const SizedBox(height: 28),

//             // OTP boxes
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(4, (i) {
//                 return SizedBox(
//                   width: 50,
//                   height: 55,
//                   child: TextField(
//                     controller: _controllers[i],
//                     focusNode: _focusNodes[i],
//                     keyboardType: TextInputType.number,
//                     textAlign: TextAlign.center,
//                     maxLength: 1,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     decoration: InputDecoration(
//                       counterText: '',
//                       filled: true,
//                       fillColor: const Color(0xFFF9F6F6),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onChanged: (v) => _onChanged(v, i),
//                   ),
//                 );
//               }),
//             ),

//             const SizedBox(height: 28),

//             // ✅ Register Button
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF064E3C),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 onPressed: () {
//                   final code = otp;
//                   if (code.length == 4) {
//                     if (widget.userType == "shopkeeper") {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => Register()),
//                       );
//                     } else if (widget.userType == "farmer") {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => Register(),
//                         ), // or your farmer dashboard
//                       );
//                     }
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Please enter all 4 digits'),
//                       ),
//                     );
//                   }
//                 },
//                 child: const Text(
//                   'Register',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),
//             TextButton(
//               onPressed: () {
//                 // Implement resend OTP
//               },
//               child: const Text(
//                 'Resend OTP',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black45,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// lib/verify_mobile_no.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart'; // your login screen (class Register)

class VerifyMobileNo extends StatefulWidget {
  final String userType;
  final String name;
  final String email;
  final String phone; // 10-digit without country code
  final String password;
  final String address;
  final String? shopName;
  final String? shopAddress;
  final String? license;

  const VerifyMobileNo({
    super.key,
    required this.userType,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    this.shopName,
    this.shopAddress,
    this.license,
  });

  @override
  State<VerifyMobileNo> createState() => _VerifyMobileNoState();
}

class _VerifyMobileNoState extends State<VerifyMobileNo> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String? _verificationId;
  bool _isLoading = false;
  int? _resendToken;
  int _secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startPhoneVerification();
    _startTimer();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _secondsLeft = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        setState(() {});
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _controllers.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get otp => _controllers.map((e) => e.text).join();

  // ---------- Firebase: send verification code ----------
  Future<void> _startPhoneVerification() async {
    setState(() => _isLoading = true);
    final phoneNumber = '+91${widget.phone}'; // India; change if needed
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification (rare). Use credential to register/link.
          await _completeRegistrationWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Phone verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          setState(() => _isLoading = false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          setState(() => _isLoading = false);
        },
        forceResendingToken: _resendToken,
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _resendOtp() async {
    // Reset inputs
    for (final c in _controllers) {
      c.clear();
    }
    await _startPhoneVerification();
    _startTimer();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('OTP resent')));
  }

  // ---------- After we have a PhoneAuthCredential ----------
  Future<void> _completeRegistrationWithCredential(
      PhoneAuthCredential phoneCredential) async {
    setState(() => _isLoading = true);
    final auth = FirebaseAuth.instance;
    try {
      // Try to create email user
      UserCredential created =
          await auth.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      // Link phone credential (attach phone to same account)
      try {
        await created.user?.linkWithCredential(phoneCredential);
      } catch (e) {
        // linking may fail if phone is already used; ignore here but log
        // you might want to handle this case in production
        debugPrint('Linking phone failed: $e');
      }

      final uid = created.user!.uid;

      // Save user data in single 'users' collection with doc id = uid
      final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
      final data = <String, dynamic>{
        'name': widget.name,
        'email': widget.email,
        'phone': '+91${widget.phone}',
        'address': widget.address,
        'userType': widget.userType,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // add shop fields only if provided (shopkeeper)
      if (widget.userType == 'shopkeeper') {
        data['shopName'] = widget.shopName ?? '';
        data['shopAddress'] = widget.shopAddress ?? '';
        data['licenseNumber'] = widget.license ?? '';
      }

      await userDoc.set(data);

      // Registration complete -> go to login screen
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful. Please login.')),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Register()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      // handle if email already in use: attempt sign-in & link
      if (e.code == 'email-already-in-use') {
        try {
          UserCredential signedIn = await auth.signInWithEmailAndPassword(
            email: widget.email,
            password: widget.password,
          );
          await signedIn.user?.linkWithCredential(phoneCredential);

          // Update user doc if exists or create if not
          final uid = signedIn.user!.uid;
          final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
          final data = {
            'name': widget.name,
            'email': widget.email,
            'phone': '+91${widget.phone}',
            'address': widget.address,
            'userType': widget.userType,
            'updatedAt': FieldValue.serverTimestamp(),
          };
          if (widget.userType == 'shopkeeper') {
            data['shopName'] = widget.shopName ?? '';
            data['shopAddress'] = widget.shopAddress ?? '';
            data['licenseNumber'] = widget.license ?? '';
          }
          await userDoc.set(data, SetOptions(merge: true));

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Phone linked to existing account. Please login.')),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => Register()),
              (route) => false,
            );
          }
        } catch (e2) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error linking phone: ${e2.toString()}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Auth error: ${e.message}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // ---------- Build UI & submit OTP ----------
  Future<void> _submitOtp() async {
    final code = otp;
    if (code.length != _controllers.length) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter full OTP')));
      return;
    }
    if (_verificationId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No verification id. Try resend.')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );
      await _completeRegistrationWithCredential(credential);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('OTP verify failed: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // show last 4 digits masked
    final masked = widget.phone.length >= 4
        ? '****${widget.phone.substring(widget.phone.length - 4)}'
        : widget.phone;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4),
            Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.5))),
            const SizedBox(height: 20),
            const Text('Verify OTP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('We have sent a ${_controllers.length}-digit OTP to +91$masked', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_controllers.length, (i) {
                return SizedBox(
                  width: 50,
                  height: 55,
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(counterText: '', filled: true, fillColor: const Color(0xFFF9F6F6), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                    onChanged: (v) => _onChanged(v, i),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitOtp,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF064E3C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('Complete Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _secondsLeft > 0 ? null : _resendOtp,
              child: Text(_secondsLeft > 0 ? 'Resend OTP in $_secondsLeft s' : 'Resend OTP'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // cancel
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
