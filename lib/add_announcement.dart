// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krushidava/shopkeeper_details.dart' show ShopkeeperDetails;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAnnouncement extends StatefulWidget {
  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  final TextEditingController _msgController = TextEditingController();
  File? _selectedImage;
  bool _loading = false;

  // Pick image from gallery
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  // Save image to local app directory
  Future<String> saveImageLocally(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName =
        'announcement_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await imageFile.copy('${appDir.path}/$fileName');
    return savedFile.path; // Return local path
  }

  // Save announcement (message + image path) to Firestore
  Future<void> saveAnnouncement() async {
    if (_msgController.text.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter message and select image")),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      // Save image locally
      String localPath = await saveImageLocally(_selectedImage!);

      // Save announcement to Firestore (only path + message)
      await FirebaseFirestore.instance.collection('announcements').add({
        "message": _msgController.text,
        "imagePath": localPath,
        "date": DateTime.now(),
      });

      setState(() {
        _msgController.clear();
        _selectedImage = null;
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Announcement added successfully!")),
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 45.78,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Center(child: Icon(Icons.arrow_back)),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Add new \nannouncement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF064E3C),
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
                              builder: (_) =>
                                  ShopkeeperDetails(userId: user.uid),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("User not logged in")),
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
                SizedBox(height: 30),

                // Image picker + message input
                Row(
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.white,
                        child: _selectedImage == null
                            ? Icon(Icons.add_a_photo, color: Colors.black)
                            : Image.file(_selectedImage!, fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        controller: _msgController,
                        decoration: InputDecoration(
                          hintText: "Insert announcement message...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),

                // Done Button
                InkWell(
                  onTap: _loading ? null : saveAnnouncement,
                  child: Container(
                    width: 145,
                    height: 51,
                    decoration: ShapeDecoration(
                      color: Color(0xFF064E3C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 30),

                // Display announcements from Firestore
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('announcements')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];

                        File imageFile = File(data['imagePath']);
                        bool exists = imageFile.existsSync();

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: exists
                                ? Image.file(
                                    imageFile,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                            title: Text(data['message'] ?? ''),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
