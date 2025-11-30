// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'manage_products.dart';
import 'shopkeeper_details.dart';

class ViewProduct extends StatelessWidget {
  final String productId;

  ViewProduct({required this.productId});

  @override
  Widget build(BuildContext context) {
    final double darkGreenHeight = 40;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF064E3C)),
              );
            }

            if (!snapshot.data!.exists) {
              return const Center(child: Text("Product not found"));
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => ManageProducts()),
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
                          child: const Icon(Icons.arrow_back, size: 20),
                        ),
                      ),

                      const SizedBox(width: 50),
                      const Text(
                        "View Product",
                        style: TextStyle(
                          color: Color(0xFF064E3C),
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
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
                                builder: (_) =>
                                    ShopkeeperDetails(userId: user.uid),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User not logged in'),
                              ),
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
                  const SizedBox(height: 20),

                  // Image and Availability
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Product Image
                      Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              data['imagePath'] != null &&
                                  data['imagePath'].toString().isNotEmpty
                              ? Image.file(
                                  File(data['imagePath']),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/pesticide1.png",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),

                      const SizedBox(width: 30),

                      // Availability
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: darkGreenHeight,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF064E3C),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Availability",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              data["availability"] ?? "Not available",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Product Name
                  buildInfoField("Product Name", data["name"] ?? ""),

                  // Technical Name
                  buildInfoField("Technical Name", data["technicalName"] ?? ""),

                  // Packaging Size
                  buildInfoField("Packaging Size", data["packagingSize"] ?? ""),

                  // Packaging Type
                  buildInfoField("Packaging Type", data["packagingType"] ?? ""),

                  // Brand
                  buildInfoField("Brand", data["brand"] ?? ""),

                  // How to Use
                  buildInfoField("How to Use?", data["howToUse"] ?? ""),

                  // Benefits
                  buildInfoField("Benefits", data["benefits"] ?? ""),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Helper widget for showing a field
  Widget buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF064E3C),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
