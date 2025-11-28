// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'side_menu_bar.dart';
import 'announcement.dart';
import 'farmer_profile.dart';
import 'home.dart';
import 'wishlist.dart';
import 'inquiry.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  bool _loading = false;

  /// Save feedback to Firestore
  Future<void> submitFeedback() async {
    if (_feedbackController.text.isEmpty || _rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please write feedback and rate us")),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('feedbacks').add({
        'feedback': _feedbackController.text,
        'rating': _rating,
        'date': DateTime.now(),
        'username': FirebaseAuth.instance.currentUser?.displayName ?? 'Farmer',
      });

      setState(() {
        _feedbackController.clear();
        _rating = 0;
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Feedback submitted successfully!")),
      );
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
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
        titleSpacing: 45,
        title: const Text(
          'Feedback',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Wishlist()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.chat_bubble,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.help_outline,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Inquiry()),
                );
              },
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

              /// ===== Give Feedback =====
              Container(
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
                    'Give Feedback',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ===== Feedback Box =====
              Container(
                width: 334,
                height: 140,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: _feedbackController,
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
                    hintText: "Write your review here...",
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

              const SizedBox(height: 20),

              /// ===== Rate Us =====
              Container(
                width: 150,
                height: 30,
                decoration: ShapeDecoration(
                  color: const Color(0xFF064E3C),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1.50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Rate Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// ===== Star Rating =====
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),

              const SizedBox(height: 20),

              /// ===== Submit Button =====
              GestureDetector(
                onTap: _loading ? null : submitFeedback,
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
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Center(
                          child: Text(
                            'Submit feedback',
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

              const SizedBox(height: 80), // spacing from bottom bar
            ],
          ),
        ),
      ),
    );
  }
}
