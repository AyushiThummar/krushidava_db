// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'shopkeeper_dashboard.dart';
import 'shopkeeper_details.dart';

class ShowFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Dashboard()),
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
                  const Spacer(),

                  // Header Text
                  const Text(
                    'Show Feedback',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),

                  // Profile icon
                  GestureDetector(
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

                    child: const Icon(
                      Icons.person_outline,
                      size: 30,
                      color: Color(0xFF064E3C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Feedback list from Firestore
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('feedbacks')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No feedbacks yet."));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        String message = data['feedback'] ?? '';
                        int rating = data['rating'] ?? 0;

                        return buildFeedbackCard(
                          userName:
                              "Farmer", // optional: use UID/email if stored
                          message: message,
                          filledStars: rating,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFeedbackCard({
    required String userName,
    required String message,
    required int filledStars,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rounded Image
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                "assets/images/profile.png", // generic profile image
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Message & Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < filledStars ? Icons.star : Icons.star_border,
                        color: const Color(0xFF064E3C),
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
