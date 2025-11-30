// // ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'shopkeeper_dashboard.dart';
import 'shopkeeper_details.dart';
import 'delete_product.dart';
import 'edit_product.dart';
import 'view_product.dart';
import 'product_management.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: SingleChildScrollView(
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

                  const Spacer(flex: 1),

                  // Centered title
                  const Text(
                    'Manage Products',
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const Spacer(flex: 1),

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
              const SizedBox(height: 20),

              // Stream of products from Firestore
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'No products yet.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        _buildAddButton(context),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      // Product cards (preserve your UI)
                      Column(
                        children: docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final imagePath = data['imagePath'] as String?;
                          final name = data['name'] ?? '';
                          final desc = data['technicalName'] ?? '';

                          final imageFile =
                              (imagePath != null && imagePath.isNotEmpty)
                              ? File(imagePath)
                              : null;
                          final exists =
                              imageFile != null && imageFile.existsSync();

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Container(
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF064E3C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Image and Name Row
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          image: exists
                                              ? DecorationImage(
                                                  image: FileImage(imageFile),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: !exists
                                            ? Image.asset(
                                                'assets/images/pesticide_placeholder.png',
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              desc,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Buttons Row
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Delete button -> open DeleteProduct with doc id
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => DeleteProduct(
                                                  productId: doc.id,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Color(0xFF064E3C),
                                          ),
                                          label: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Color(0xFF064E3C),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        // Edit button -> open EditProduct with doc id
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => EditProduct(
                                                  productId: doc.id,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color(0xFF064E3C),
                                          ),
                                          label: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Color(0xFF064E3C),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        // View button -> open ViewProduct with doc id
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => ViewProduct(
                                                  productId: doc.id,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.visibility,
                                            color: Color(0xFF064E3C),
                                          ),
                                          label: const Text(
                                            'View',
                                            style: TextStyle(
                                              color: Color(0xFF064E3C),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),
                      // Add New Product Button
                      _buildAddButton(context),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProductManagement()),
        );
      },
      child: Container(
        width: 197,
        height: 55,
        decoration: ShapeDecoration(
          color: const Color(0xFF064E3C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Add a new product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
