// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'show_inquiry.dart';
import 'shopkeeper_details.dart';

class ReplyInquiry extends StatelessWidget {
  final String userName;
  final String inquiryText;
  final String docId;

  // Constructor to accept data
  ReplyInquiry({
    required this.userName,
    required this.inquiryText,
    required this.docId,
  });

  final TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ShowInquiry()),
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
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Reply Inquiry',
                    style: TextStyle(
                      color: const Color(0xFF064E3C),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Spacer(),

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

                    child: Icon(
                      Icons.person_outline,
                      size: 30,
                      color: Color(0xFF064E3C),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // User card
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
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
                            userName, // Dynamic username
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            inquiryText, // Dynamic inquiry text
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Green label
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF064E3C),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Enter your reply",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Reply input
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextField(
                  controller: replyController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Write your reply here...",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // ✅ Send button
              Center(
                child: SizedBox(
                  width: 145,
                  height: 51,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF064E3C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      String replyText = replyController.text.trim();
                      if (replyText.isNotEmpty) {
                        // Save reply to Firestore under the same inquiry
                        await FirebaseFirestore.instance
                            .collection('inquiries')
                            .doc(docId)
                            .update({'reply': replyText});

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Reply sent successfully")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => ShowInquiry()),
                        );
                      }
                    },
                    icon: Icon(Icons.send, color: Colors.white),
                    label: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
