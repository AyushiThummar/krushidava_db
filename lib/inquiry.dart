// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'side_menu_bar.dart';
import 'announcement.dart';
import 'farmer_profile.dart';
import 'home.dart';
import 'wishlist.dart';
import 'feedback.dart';

class Inquiry extends StatefulWidget {
  const Inquiry({super.key});

  @override
  State<Inquiry> createState() => _InquiryState();
}

class _InquiryState extends State<Inquiry> {
  final TextEditingController inquiryController = TextEditingController();

  Future<void> submitInquiry() async {
    String message = inquiryController.text.trim();
    if (message.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('inquiries').add({
        "inquiry": message,
        "uid": FirebaseAuth.instance.currentUser?.uid ?? "unknown",
        "username": "Farmer", // static name same as feedback
        "date": DateTime.now(),
      });

      inquiryController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inquiry submitted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      drawer: Drawer(child: SideMenuBar(parentContext: context)),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1FCF9),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF064E3C), size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 60,
        title: const Text(
          'Inquiry',
          style: TextStyle(
            color: Color(0xFF064E3C),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF064E3C),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Announcement()),
              );
            },
          ),
          const SizedBox(width: 1),
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Color(0xFF064E3C),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
          ),
          const SizedBox(width: 30),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_outline,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Wishlist()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.chat_bubble_outline,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const FeedbackPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.help, size: 35, color: Color(0xFF064E3C)),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),

              SizedBox(
                width: double.infinity,
                height: 400,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 338,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Enter your doubt here',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 334,
                          height: 140,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: TextField(
                            controller: inquiryController,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Ask your question here...',
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 220,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: submitInquiry,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 220,
                            height: 49,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF064E3C),
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
                              child: Text(
                                'Submit inquiry',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
