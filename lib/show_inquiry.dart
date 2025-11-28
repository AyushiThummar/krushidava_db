// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'shopkeeper_dashboard.dart';
import 'reply_inquiry.dart';
import 'shopkeeper_details.dart';

class ShowInquiry extends StatelessWidget {
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

                  const Text(
                    'Show Inquiry',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const Spacer(),

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

              // Inquiry List
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('inquiries')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No inquiries yet."));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        String username = data['username'] ?? "Farmer";
                        String inquiryText = data['inquiry'] ?? '';

                        return buildInquiryCard(
                          context: context,
                          userName: username,
                          inquiryMessage: inquiryText,
                          docId: data.id, // <-- pass document ID here
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

  // Updated Inquiry Card with Reply Button
  Widget buildInquiryCard({
    required BuildContext context,
    required String userName,
    required String inquiryMessage,
    required String docId, // added
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
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    "assets/images/profile.png",
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        inquiryMessage,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Reply Button
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReplyInquiry(
                        userName: userName,
                        inquiryText: inquiryMessage,
                        docId: docId, // <-- pass document ID
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF064E3C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.reply, size: 18, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        "Reply",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
