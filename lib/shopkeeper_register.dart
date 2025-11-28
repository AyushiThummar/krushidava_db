// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:krushidava/verify_mobile_no.dart';

// class RegisterShopkeeper extends StatefulWidget {
//   const RegisterShopkeeper({super.key});

//   @override
//   State<RegisterShopkeeper> createState() => _RegisterShopkeeperState();
// }

// class _RegisterShopkeeperState extends State<RegisterShopkeeper> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final TextEditingController shopNameController = TextEditingController();
//   final TextEditingController shopAddressController = TextEditingController();
//   final TextEditingController licenseController = TextEditingController();

//   void _onRegisterPressed() {
//     if (_formKey.currentState!.validate()) {
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         builder: (_) => Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: VerifyMobileNo(userType: "shopkeeper"),
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
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             children: [
//               // ===== Top Section =====
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
//                         'Shopkeeper Registration',
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

//               // ===== Input Fields =====
//               buildTextField(
//                 "Name*",
//                 "Your full name",
//                 nameController,
//                 inputFormatters: [
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
//                   final pwPattern =
//                       r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
//                   if (!RegExp(pwPattern).hasMatch(value)) {
//                     return "Must be 8+ chars with upper, lower, number & special char";
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
//               buildTextField(
//                 "Shop Name*",
//                 "Your shop name",
//                 shopNameController,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Shop name is required";
//                   }
//                   return null;
//                 },
//               ),
//               buildTextField(
//                 "Shop Address*",
//                 "Your shop address",
//                 shopAddressController,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Shop address is required";
//                   }
//                   return null;
//                 },
//               ),
//               buildTextField(
//                 "License no*",
//                 "Your license number",
//                 licenseController,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "License number is required";
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(height: 30),

//               // ===== Register Button =====
//               ElevatedButton(
//                 onPressed: _onRegisterPressed,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFC5DCD7),
//                   foregroundColor: Colors.black,
//                   minimumSize: const Size(340, 60),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     side: const BorderSide(
//                       color: Color(0xFF064E3C),
//                       width: 1.5,
//                     ),
//                   ),
//                   elevation: 0,
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

//   // === Reusable TextField ===
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
//               errorStyle: const TextStyle(
//                 color: Color.fromARGB(255, 131, 1, 1),
//                 fontSize: 12,
//               ),
//               errorMaxLines: 3,
//               counterText: '',
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

class RegisterShopkeeper extends StatefulWidget {
  const RegisterShopkeeper({super.key});

  @override
  State<RegisterShopkeeper> createState() => _RegisterShopkeeperState();
}

class _RegisterShopkeeperState extends State<RegisterShopkeeper> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopAddressController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();

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
            userType: "shopkeeper",
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            phone: mobileController.text.trim(),
            password: passwordController.text.trim(),
            address: addressController.text.trim(),
            shopName: shopNameController.text.trim(),
            shopAddress: shopAddressController.text.trim(),
            license: licenseController.text.trim(),
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
              // ===== Top Section =====
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
                        'Shopkeeper Registration',
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

              // ===== Input Fields =====
              buildTextField(
                "Name*",
                "Your full name",
                nameController,
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
                    return "Must be 8+ chars with upper, lower, number & special char";
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
              buildTextField(
                "Shop Name*",
                "Your shop name",
                shopNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Shop name is required";
                  }
                  return null;
                },
              ),
              buildTextField(
                "Shop Address*",
                "Your shop address",
                shopAddressController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Shop address is required";
                  }
                  return null;
                },
              ),
              buildTextField(
                "License no*",
                "Your license number",
                licenseController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "License number is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // ===== Register Button =====
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

  // === Reusable TextField ===
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
