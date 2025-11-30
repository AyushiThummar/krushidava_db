// // ignore_for_file: use_key_in_widget_constructors, avoid_print

// import 'package:flutter/material.dart';
// import 'package:krushidava/home.dart'; // Farmer home
// import 'package:krushidava/shopkeeper_dashboard.dart'; // Shopkeeper dashboard
// import 'package:krushidava/forgot_password.dart';
// import 'package:krushidava/selection.dart';

// class Register extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE1FCF9),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               padding: EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 20),

//                       Text(
//                         'Welcome back!',
//                         style: TextStyle(
//                           color: const Color(0xFF064E3C),
//                           fontSize: 25,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       Container(
//                         width: 240,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage("assets/images/login.png"),
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 40),

//                       TextField(
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           hintText: "Email id",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: const Color(0xFF064E3C),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       TextField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: const Color(0xFF064E3C),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => ForgotPassword(),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             "Forgot your login details?",
//                             style: TextStyle(
//                               color: const Color(0xFF064E3C),
//                               fontSize: 14,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 60,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF064E3C),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           onPressed: () {
//                             String email = emailController.text.trim();
//                             String password = passwordController.text.trim();

//                             if (email.isEmpty || password.isEmpty) {
//                               _showSnack(
//                                 context,
//                                 "Please enter Email and Password",
//                                 true,
//                               );
//                               return;
//                             }

//                             if (email == "abc@gmail.com" &&
//                                 password == "Abc@148") {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const HomePage(),
//                                 ),
//                               );
//                               _showSnack(
//                                 context,
//                                 "Farmer login successful",
//                                 false,
//                               );
//                             } else if (email == "xyz@gmail.com" &&
//                                 password == "Xyz@148") {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(builder: (_) => Dashboard()),
//                               );
//                               _showSnack(
//                                 context,
//                                 "Shopkeeper login successful",
//                                 false,
//                               );
//                             } else {
//                               _showSnack(
//                                 context,
//                                 "Invalid Email or Password",
//                                 true,
//                               );
//                             }
//                           },
//                           child: Text(
//                             'Get Started',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Don’t have an account?',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (_) => Selection()),
//                               );
//                             },
//                             child: Text(
//                               'Register here',
//                               style: TextStyle(
//                                 color: const Color(0xFF064E3C),
//                                 fontSize: 16,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void _showSnack(BuildContext context, String message, bool isError) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError
//             ? const Color(0xFFB71C1C)
//             : const Color(0xFF064E3C),
//       ),
//     );
//   }
// }
// ignore_for_file: use_key_in_widget_constructors, avoid_print, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krushidava/home.dart'; // Farmer home
import 'package:krushidava/shopkeeper_dashboard.dart'; // Shopkeeper dashboard
import 'package:krushidava/forgot_password.dart';
import 'package:krushidava/selection.dart';

class Register extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      Text(
                        'Welcome back!',
                        style: TextStyle(
                          color: const Color(0xFF064E3C),
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: 240,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/login.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email id",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: const Color(0xFF064E3C),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: const Color(0xFF064E3C),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot your login details?",
                            style: TextStyle(
                              color: const Color(0xFF064E3C),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF064E3C),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              _showSnack(
                                context,
                                "Please enter Email and Password",
                                true,
                              );
                              return;
                            }

                            try {
                              // Login with Firebase
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );

                              // Get user data from Firestore
                              DocumentSnapshot doc = await FirebaseFirestore
                                  .instance
                                  .collection(
                                    'users',
                                  ) // Single collection for all users
                                  .doc(userCredential.user!.uid)
                                  .get();

                              if (!doc.exists) {
                                _showSnack(
                                  context,
                                  "User data not found",
                                  true,
                                );
                                return;
                              }

                              String userType = doc.get(
                                'userType',
                              ); // 'farmer' or 'shopkeeper'

                              if (userType == 'farmer') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomePage(),
                                  ),
                                );
                                _showSnack(
                                  context,
                                  "Farmer login successful",
                                  false,
                                );
                              } else if (userType == 'shopkeeper') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Dashboard(),
                                  ),
                                );
                                _showSnack(
                                  context,
                                  "Shopkeeper login successful",
                                  false,
                                );
                              } else {
                                _showSnack(context, "Unknown user type", true);
                              }
                            } on FirebaseAuthException catch (e) {
                              _showSnack(
                                context,
                                e.message ?? "Login failed",
                                true,
                              );
                            }
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Selection()),
                              );
                            },
                            child: Text(
                              'Register here',
                              style: TextStyle(
                                color: const Color(0xFF064E3C),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? const Color(0xFFB71C1C)
            : const Color(0xFF064E3C),
      ),
    );
  }
}
