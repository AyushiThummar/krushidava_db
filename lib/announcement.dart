// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement extends StatelessWidget {
  const Announcement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              /// --- Top Bar ---
              Positioned(
                left: 20,
                top: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                top: 25,
                child: const Center(
                  child: Text(
                    'Announcements',
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              /// --- Announcements List ---
              Positioned(
                top: 80,
                left: 20,
                right: 20,
                bottom: 20,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('announcements')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = snapshot.data!.docs;

                    if (docs.isEmpty) {
                      return const Center(child: Text("No announcements yet"));
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: docs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final data = docs[index];
                        final message = data['message'] ?? '';
                        final imagePath = data['imagePath'] ?? '';

                        File imageFile = File(imagePath);
                        bool exists = imageFile.existsSync();

                        return _buildAnnouncementItem(
                          iconUrl: exists ? imagePath : '',
                          text: message,
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

  /// Widget for each announcement item
  Widget _buildAnnouncementItem({
    required String iconUrl,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: iconUrl.isNotEmpty
                ? DecorationImage(
                    image: FileImage(File(iconUrl)),
                    fit: BoxFit.cover,
                  )
                : null,
            color: iconUrl.isEmpty ? Colors.grey[300] : null,
          ),
          child: iconUrl.isEmpty
              ? const Icon(
                  Icons.image_not_supported,
                  size: 24,
                  color: Colors.grey,
                )
              : null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 43,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF064E3C),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
