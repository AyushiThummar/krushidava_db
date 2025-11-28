// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'shopkeeper_dashboard.dart';
import 'shopkeeper_details.dart';
import 'delete_product.dart';
import 'edit_product.dart';
import 'view_product.dart';
import 'product_management.dart';

class ManageProducts extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'name': 'Liquid RAMBO-50',
      'desc': '(CHLORPYRIFOS 50% EC)',
      'image': 'assets/images/pesticide1.png',
    },
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
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),

                  Spacer(flex: 1),

                  // Centered title
                  Text(
                    'Manage Products',
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  Spacer(flex: 1),

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
              SizedBox(height: 20),

              // Products List
              Column(
                children: products.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> product = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: Color(0xFF064E3C),
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
                                margin: EdgeInsets.all(8),
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
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      product['desc']!,
                                      style: TextStyle(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Delete button
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: index == 0
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => DeleteProduct(),
                                            ),
                                          );
                                        }
                                      : () {}, // do nothing for other products
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color(0xFF064E3C),
                                  ),
                                  label: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Color(0xFF064E3C),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                // Edit button
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: index == 0
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => EditProduct(),
                                            ),
                                          );
                                        }
                                      : () {}, // do nothing for others
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color(0xFF064E3C),
                                  ),
                                  label: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Color(0xFF064E3C),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                // View button
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: index == 0
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ViewProduct(),
                                            ),
                                          );
                                        }
                                      : () {}, // do nothing for others
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Color(0xFF064E3C),
                                  ),
                                  label: Text(
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

              SizedBox(height: 20),
              // Add New Product Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProductManagement()),
                  );
                },
                child: Container(
                  width: 197,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: Color(0xFF064E3C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
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
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
