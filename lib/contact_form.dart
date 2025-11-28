// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'shopkeeper_dashboard.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // Controllers for editable fields
  TextEditingController addressController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  // Default values
  String personName = "Person name";
  String mobileNumber = "+91 XXXXX XXXXX";
  String whatsappNumber = "+91 XXXXX XXXXX";
  String? imageUrl; // old cloud URL
  String? savedImagePath; // local path

  bool isLoading = true;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    loadContactDetails();
  }

  // Load existing contact details from Firestore
  Future<void> loadContactDetails() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("contactDetails")
        .doc(uid)
        .get();

    if (snap.exists) {
      setState(() {
        personName = snap["name"] ?? "Person name";
        mobileNumber = snap["mobile"] ?? "+91 XXXXX XXXXX";
        whatsappNumber = snap["whatsapp"] ?? "+91 XXXXX XXXXX";
        addressController.text = snap["address"] ?? "---------------------";
        timeController.text = snap["time"] ?? "8:00 AM to 10:00 PM";

        savedImagePath = snap["imagePath"];
        imageUrl = snap["imageUrl"];

        if (savedImagePath != null && File(savedImagePath!).existsSync()) {
          profileImage = File(savedImagePath!);
        }

        isLoading = false;
      });
    } else {
      setState(() {
        addressController.text = "---------------------";
        timeController.text = "8:00 AM to 10:00 PM";
        isLoading = false;
      });
    }
  }

  // Pick image locally & save path in Firestore
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final file = File(picked.path);

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = "contact_${DateTime.now().millisecondsSinceEpoch}.jpg";
      final savedFile = await file.copy("${appDir.path}/$fileName");

      setState(() {
        profileImage = savedFile;
        savedImagePath = savedFile.path;
      });

      saveImagePath(savedImagePath!);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving image: $e")));
    }
  }

  Future<void> saveImagePath(String path) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance.collection("contactDetails").doc(uid).set({
      "imagePath": path,
      "imageUrl": "",
    }, SetOptions(merge: true));
  }

  // Save updated contact details to Firestore
  Future<void> saveContactDetails() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance.collection("contactDetails").doc(uid).set({
      "name": personName,
      "mobile": mobileNumber,
      "whatsapp": whatsappNumber,
      "address": addressController.text.trim(),
      "time": timeController.text.trim(),
      "imagePath": savedImagePath,
      "imageUrl": imageUrl,
    }, SetOptions(merge: true));
  }

  // ImageProvider Logic (local > network > asset)
  ImageProvider avatar() {
    if (profileImage != null) return FileImage(profileImage!) as ImageProvider;
    if (savedImagePath != null && File(savedImagePath!).existsSync())
      return FileImage(File(savedImagePath!));
    if (imageUrl != null && imageUrl!.isNotEmpty)
      return NetworkImage(imageUrl!);
    return const AssetImage("assets/images/profile.png");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  child: Center(
                    child: Text(
                      'Contact Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                // Back button
                Positioned(
                  left: 25,
                  top: 45,
                  child: GestureDetector(
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
                ),

                // User photo with camera icon
                Positioned(
                  top: 200,
                  left: screenWidth / 2 - 50,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: avatar(),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: pickImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Color(0xFF064E3C),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 60),

            Text(
              personName,
              style: TextStyle(
                color: const Color(0xFF064E3C),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  buildStyledField("Mobile Number", mobileNumber),
                  SizedBox(height: 25),
                  buildStyledField("WhatsApp Number", whatsappNumber),
                  SizedBox(height: 25),
                  buildEditableField(
                    "Shop Address",
                    addressController,
                    multiline: true,
                  ),
                  SizedBox(height: 25),
                  buildEditableField("Time", timeController),
                  SizedBox(height: 50),

                  GestureDetector(
                    onTap: () async {
                      await saveContactDetails();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Dashboard()),
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
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
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

                  SizedBox(height: 30),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => Register()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Non-editable field
  Widget buildStyledField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF064E3C),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Editable field
  Widget buildEditableField(
    String label,
    TextEditingController controller, {
    bool multiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF064E3C),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: multiline ? null : 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 8),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.edit, color: Colors.black54, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
