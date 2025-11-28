// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'manage_products.dart';
import 'shopkeeper_details.dart';
import 'product_management.dart';

class DeleteProduct extends StatelessWidget {
  final List<Map<String, String>> products = [
    // Removed the first product
    {
      'name': 'TOLFENPYRAD 15 EC',
      'desc': 'INSECTICIDE, 500',
      'image': 'assets/images/pesticide2.png',
    },
    {
      'name': 'LIQUID BIO AGRICULTURAL',
      'desc': 'PESTICIDES SPG',
      'image': 'assets/images/pesticide3.png',
    },
  ];

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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => ManageProducts()),
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

                  const Spacer(),
                  const Text(
                    'Delete Products',
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
              const SizedBox(height: 20),

              // Products List
              Column(
                children: products.map((product) {
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
                          // Image + Name/Description
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: AssetImage(product['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['desc']!,
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

                          // Action Buttons
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {},
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
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {},
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
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {},
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

              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ProductManagement()),
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
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
