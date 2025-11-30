// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krushidava/home.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users') // your farmers/users collection
            .doc(currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF064E3C)),
            );
          }

          if (!snapshot.data!.exists) {
            return const Center(child: Text("Data not found for this user"));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          addressController.text = userData['address'] ?? "";

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Green header
                    Container(
                      width: double.infinity,
                      height: 260,
                      color: const Color(0xFF008575),
                      child: const Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),

                    // Back Button
                    Positioned(
                      left: 25,
                      top: 45,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                          );
                        },
                        child: Container(
                          width: 45,
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
                    ),

                    // Profile Image
                    Positioned(
                      top: 200,
                      left: screenWidth / 2 - 50,
                      child: Stack(
                        children: const [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage(
                                "assets/images/profile.png",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Dynamic Name
                Text(
                  userData['name'] ?? "",
                  style: const TextStyle(
                    color: Color(0xFF064E3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      buildStyledField("Mobile Number", userData['phone']),
                      const SizedBox(height: 25),
                      buildStyledField("Email", userData['email']),
                      const SizedBox(height: 25),

                      // Editable Address
                      buildStyledField(
                        "Address",
                        userData['address'],
                        isEditable: true,
                        showEdit: true,
                        controller: addressController,
                      ),
                      const SizedBox(height: 50),

                      // Update Profile Button
                      GestureDetector(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(currentUser.uid)
                              .update({
                                "address": addressController.text.trim(),
                              });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Profile Updated Successfully"),
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Update Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Logout Button
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.logout, color: Colors.black, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildStyledField(
    String label,
    String value, {
    bool showEdit = false,
    bool isEditable = false,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF064E3C),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: isEditable
                    ? TextField(
                        controller: controller,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      )
                    : Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                        maxLines: null,
                      ),
              ),
              if (showEdit)
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.edit, color: Colors.black54, size: 18),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
