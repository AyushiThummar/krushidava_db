// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product_details_farmer_dynamic.dart';
import 'home.dart';
import 'side_menu_bar.dart';
import 'announcement.dart';
import 'farmer_profile.dart';
import 'feedback.dart';
import 'inquiry.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  Future<List<Map<String, dynamic>>> _fetchWishlistProducts(
    String userId,
  ) async {
    // Fetch wishlist items (no orderBy to avoid index requirement)
    final wishlistSnapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .where('userId', isEqualTo: userId)
        .get();

    // Sort by addedAt in Dart (newest first)
    final sortedWishlist = wishlistSnapshot.docs.toList()
      ..sort((a, b) {
        final aTime = a['addedAt'] as Timestamp;
        final bTime = b['addedAt'] as Timestamp;
        return bTime.compareTo(aTime);
      });

    final List<Map<String, dynamic>> products = [];

    for (var doc in sortedWishlist) {
      final productId = doc['productId'];
      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      if (productDoc.exists) {
        final data = productDoc.data()!;
        data['wishlistId'] = doc.id; // save wishlist document id for delete
        products.add(data);
      }
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('User not logged in')));
    }

    final userId = user.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      drawer: Drawer(child: SideMenuBar(parentContext: context)),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1FCF9),
        elevation: 0,
        titleSpacing: 55,
        title: const Text(
          'Wishlist',
          style: TextStyle(
            color: Color(0xFF064E3C),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF064E3C), size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF064E3C),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Announcement()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Color(0xFF064E3C),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
          ),
          const SizedBox(width: 30),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.chat_bubble_outline,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FeedbackPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.help_outline,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Inquiry()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchWishlistProducts(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(
              child: Text(
                'No Products in Wishlist',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 320,
            ),
            itemBuilder: (context, index) {
              final data = products[index];
              final imagePath = data['imagePath'] ?? '';
              Widget productImage = Image.asset(
                'assets/images/pesticide_placeholder.png',
                fit: BoxFit.cover,
              );
              if (imagePath.startsWith('http'))
                productImage = Image.network(imagePath, fit: BoxFit.cover);
              else if (imagePath.isNotEmpty && File(imagePath).existsSync())
                productImage = Image.file(File(imagePath), fit: BoxFit.cover);

              return _buildProductCard(
                context,
                imageWidget: productImage,
                title: data['technicalName'] ?? '',
                subtitle: data['name'] ?? '',
                price: data['packagingSize'] ?? '',
                liked: true,
                onLikeToggle: () {
                  final wishlistId = data['wishlistId'];
                  FirebaseFirestore.instance
                      .collection('wishlist')
                      .doc(wishlistId)
                      .delete();
                },
                productData: data,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, {
    required Widget imageWidget,
    required String title,
    required String subtitle,
    required String price,
    required bool liked,
    required VoidCallback onLikeToggle,
    Map<String, dynamic>? productData,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: FittedBox(fit: BoxFit.cover, child: imageWidget),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
                Text(
                  price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (productData != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsFarmerDynamic(
                            productData: productData,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF008575),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Read more",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onLikeToggle,
                  child: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xFF064E3C),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
