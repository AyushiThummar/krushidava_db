// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'manage_products.dart';
import 'add_announcement.dart';
import 'show_feedback.dart';
import 'show_inquiry.dart';
import 'contact_form.dart';
import 'shopkeeper_details.dart'; // for profile

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: 412,
            height: 1000,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: const Color(0xFFE1FCF9)),
            child: Stack(
              children: [
                // App Title
                Positioned(
                  left: 120,
                  top: 42,
                  child: Text(
                    'Krushi Dava',
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 24,
                      fontFamily: 'Merienda One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Profile Icon
                // Profile Icon
                Positioned(
                  right: 20,
                  top: 44,
                  child: GestureDetector(
                    onTap: () {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ShopkeeperDetails(userId: user.uid),
                          ),
                        );
                      } else {
                        // User is not logged in, show a message or redirect
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User not logged in')),
                        );
                      }
                    },

                    child: Icon(
                      Icons.person_outline,
                      size: 30,
                      color: Color(0xFF064E3C),
                    ),
                  ),
                ),

                /// PRODUCT MANAGEMENT
                Positioned(
                  left: 34,
                  top: 148,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ManageProducts()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/product_management.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 39,
                  top: 314,
                  child: Text(
                    'PRODUCT  \nMANAGEMENT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                /// ADD ANNOUNCEMENT
                Positioned(
                  left: 226,
                  top: 148,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddAnnouncement()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/add_announcement.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 210,
                  top: 314,
                  child: Text(
                    'ADD \nANNOUNCEMENT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                /// SHOW FEEDBACK
                Positioned(
                  left: 34,
                  top: 425,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ShowFeedback()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/show_feedback.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 591,
                  child: Text(
                    'SHOW \nFEEDBACK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                /// SHOW INQUIRY
                Positioned(
                  left: 226,
                  top: 425,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ShowInquiry()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/show_inquiry.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 259,
                  top: 591,
                  child: Text(
                    'SHOW \nINQUIRY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                /// CONTACT DETAILS
                Positioned(
                  left: 34,
                  top: 678,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ContactForm()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/contact_shopkeeper.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 65,
                  top: 848,
                  child: Text(
                    'CONTACT \nDETAILS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
