// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:krushidava/verify_mobile_no.dart';

// class RegisterFarmer extends StatefulWidget {
//   const RegisterFarmer({super.key});

//   @override
//   State<RegisterFarmer> createState() => _RegisterFarmerState();
// }

// class _RegisterFarmerState extends State<RegisterFarmer> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Re-validate whenever any relevant field changes so errors update immediately.
//     void listener() {
//       // if form has been created, validate it (safe guard)
//       if (_formKey.currentState != null) _formKey.currentState!.validate();
//     }

//     nameController.addListener(listener);
//     mobileController.addListener(listener);
//     emailController.addListener(listener);
//     addressController.addListener(listener);
//     passwordController.addListener(listener);
//     confirmPasswordController.addListener(listener);
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     mobileController.dispose();
//     emailController.dispose();
//     addressController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _onRegisterPressed() {
//     // Final check before proceeding
//     if (_formKey.currentState!.validate()) {
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         builder: (_) => Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: VerifyMobileNo(userType: "farmer"), // ✅ Pass userType
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           // validate automatically once user interacts with fields
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             children: [
//               // ===== Top section with back button & title =====
//               Container(
//                 width: double.infinity,
//                 height: 250,
//                 decoration: const BoxDecoration(
//                   color: Color(0xE0C9FDF7),
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(25),
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 20,
//                       top: 40,
//                       child: InkWell(
//                         onTap: () => Navigator.pop(context),
//                         borderRadius: BorderRadius.circular(15),
//                         child: Container(
//                           width: 45,
//                           height: 35,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 4,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: const Icon(
//                             Icons.arrow_back,
//                             size: 24,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'Farmer Registration',
//                         style: TextStyle(
//                           color: Color(0xFF064E3C),
//                           fontSize: 22,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ===== Input fields =====
//               buildTextField(
//                 "Name*",
//                 "Your full name",
//                 nameController,
//                 keyboardType: TextInputType.name,
//                 inputFormatters: [
//                   // allow only letters and spaces
//                   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                 ],
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Name is required";
//                   }
//                   if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
//                     return "Only letters and spaces allowed";
//                   }
//                   return null;
//                 },
//               ),
//               buildTextField(
//                 "Mobile no*",
//                 "Your mobile no",
//                 mobileController,
//                 keyboardType: TextInputType.phone,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                   LengthLimitingTextInputFormatter(10),
//                 ],
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Mobile number is required";
//                   }
//                   if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
//                     return "Enter a valid 10-digit number";
//                   }
//                   return null;
//                 },
//               ),
//               buildTextField(
//                 "Email*",
//                 "Your email",
//                 emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Email is required";
//                   }
//                   if (!RegExp(
//                     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                   ).hasMatch(value.trim())) {
//                     return "Enter a valid email";
//                   }
//                   return null;
//                 },
//               ),
//               buildTextField(
//                 "Address*",
//                 "Your address",
//                 addressController,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Address is required";
//                   }
//                   return null;
//                 },
//               ),
//               buildTextField(
//                 "Password*",
//                 "Your password",
//                 passwordController,
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Password is required";
//                   }
//                   // At least 1 lower, 1 upper, 1 number, 1 special, min 8 chars
//                   final pwPattern =
//                       r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
//                   if (!RegExp(pwPattern).hasMatch(value)) {
//                     return "Must be 8+ chars and include upper, lower, number & special char";
//                   }
//                   return null;
//                 },
//               ),
//               buildTextField(
//                 "Confirm Password*",
//                 "Re-enter your password",
//                 confirmPasswordController,
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Confirm your password";
//                   }
//                   if (value != passwordController.text) {
//                     return "Passwords do not match";
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(height: 30),

//               // ===== Register Button =====
//               ElevatedButton(
//                 onPressed: _onRegisterPressed,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFC5DCD7), // light background
//                   foregroundColor: Colors.black, // text color
//                   minimumSize: const Size(340, 60),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     side: const BorderSide(
//                       color: Color(0xFF064E3C), // border color (#064E3C)
//                       width: 1.5,
//                     ),
//                   ),
//                   elevation: 0, // flat button look
//                 ),
//                 child: const Text(
//                   "Register",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//               ),

//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // === Reusable TextField with Validation ===
//   Widget buildTextField(
//     String label,
//     String hint,
//     TextEditingController controller, {
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     List<TextInputFormatter>? inputFormatters,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 5),
//           TextFormField(
//             controller: controller,
//             obscureText: obscureText,
//             keyboardType: keyboardType,
//             inputFormatters: inputFormatters,
//             validator: validator,
//             // also validate per-field on user interaction (Form already does this,
//             // but having per-field autovalidation is harmless and immediate)
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             decoration: InputDecoration(
//               hintText: hint,
//               filled: true,
//               fillColor: const Color(0xFF064E3C),
//               hintStyle: const TextStyle(color: Colors.white70),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 15,
//                 vertical: 12,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide.none,
//               ),
//               // ensure errors can wrap and show clearly
//               errorStyle: const TextStyle(
//                 color: Color.fromARGB(255, 131, 1, 1),
//                 fontSize: 12,
//               ),
//               errorMaxLines: 3,
//               counterText:
//                   '', // hide length counter when using LengthLimitingTextInputFormatter
//             ),
//             style: const TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krushidava/verify_mobile_no.dart';

class RegisterFarmer extends StatefulWidget {
  const RegisterFarmer({super.key});

  @override
  State<RegisterFarmer> createState() => _RegisterFarmerState();
}

class _RegisterFarmerState extends State<RegisterFarmer> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    void listener() {
      if (_formKey.currentState != null) _formKey.currentState!.validate();
    }

    nameController.addListener(listener);
    mobileController.addListener(listener);
    emailController.addListener(listener);
    addressController.addListener(listener);
    passwordController.addListener(listener);
    confirmPasswordController.addListener(listener);
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // 🚀 Corrected Register Button
  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: VerifyMobileNo(
            userType: "farmer",
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            phone: mobileController.text.trim(), // ✅ Correct parameter
            password: passwordController.text.trim(),
            address: addressController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // 🔷 TOP HEADER SECTION (unchanged UI)
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  color: Color(0xE0C9FDF7),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 40,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 45,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Farmer Registration',
                        style: TextStyle(
                          color: Color(0xFF064E3C),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔷 INPUT FIELDS
              buildTextField(
                "Name*",
                "Your full name",
                nameController,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is required";
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                    return "Only letters and spaces allowed";
                  }
                  return null;
                },
              ),

              buildTextField(
                "Mobile no*",
                "Your mobile no",
                mobileController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Mobile number is required";
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                    return "Enter a valid 10-digit number";
                  }
                  return null;
                },
              ),

              buildTextField(
                "Email*",
                "Your email",
                emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),

              buildTextField(
                "Address*",
                "Your address",
                addressController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Address is required";
                  }
                  return null;
                },
              ),

              buildTextField(
                "Password*",
                "Your password",
                passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  final pwPattern =
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                  if (!RegExp(pwPattern).hasMatch(value)) {
                    return "Must include upper, lower, number & special char";
                  }
                  return null;
                },
              ),

              buildTextField(
                "Confirm Password*",
                "Re-enter your password",
                confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm your password";
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // 🔷 REGISTER BUTTON
              ElevatedButton(
                onPressed: _onRegisterPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC5DCD7),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(340, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF064E3C),
                      width: 1.5,
                    ),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // 🔷 Reusable Custom TextField (UI unchanged)
  Widget buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFF064E3C),
              hintStyle: const TextStyle(color: Colors.white70),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              errorStyle: const TextStyle(
                color: Color.fromARGB(255, 131, 1, 1),
                fontSize: 12,
              ),
              errorMaxLines: 3,
              counterText: '',
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
