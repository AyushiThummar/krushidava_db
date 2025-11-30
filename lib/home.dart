// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:krushidava/product_details_farmer_dynamic.dart';
import 'farmer_profile.dart';
import 'side_menu_bar.dart';
import 'announcement.dart';
import 'wishlist.dart';
import 'feedback.dart';
import 'inquiry.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      drawer: Drawer(child: SideMenuBar(parentContext: context)),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1FCF9),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF064E3C), size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 30,
        title: const Text(
          'Krushi Dava',
          style: TextStyle(
            color: Color(0xFF064E3C),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
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
          const SizedBox(width: 1),
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
              icon: const Icon(Icons.home, size: 35, color: Color(0xFF064E3C)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Wishlist()),
                );
              },
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No products found"));
                }

                final products = snapshot.data!.docs;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 330,
                  ),
                  itemBuilder: (context, index) {
                    final doc = products[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final productId = doc.id;

                    Widget productImage = Image.asset(
                      'assets/images/pesticide1.png',
                      fit: BoxFit.cover,
                    );

                    final imagePath = data['imagePath'] ?? '';
                    if (imagePath.startsWith('http')) {
                      productImage = Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                      );
                    } else if (File(imagePath).existsSync()) {
                      productImage = Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      );
                    }

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('wishlist')
                          .where('userId', isEqualTo: userId)
                          .where('productId', isEqualTo: productId)
                          .snapshots(),
                      builder: (context, wishlistSnapshot) {
                        final isLiked =
                            wishlistSnapshot.hasData &&
                            wishlistSnapshot.data!.docs.isNotEmpty;

                        return _buildProductCard(
                          context,
                          imageWidget: productImage,
                          title: data['technicalName'] ?? '',
                          subtitle: data['name'] ?? '',
                          price: data['packagingSize'] ?? '',
                          liked: isLiked,
                          productData: data,
                          productId: productId,
                          userId: userId!,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- PRODUCT CARD ----------------
  Widget _buildProductCard(
    BuildContext context, {
    required Widget imageWidget,
    required String title,
    required String subtitle,
    required String price,
    required bool liked,
    Map<String, dynamic>? productData,
    String? productId,
    String? userId,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageWidget,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
          const Spacer(),
          Row(
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
                onTap: () async {
                  if (productId == null || userId == null) return;
                  final wishlistRef = FirebaseFirestore.instance.collection(
                    'wishlist',
                  );
                  final doc = await wishlistRef
                      .where('userId', isEqualTo: userId)
                      .where('productId', isEqualTo: productId)
                      .get();

                  if (doc.docs.isEmpty) {
                    wishlistRef.add({
                      'userId': userId,
                      'productId': productId,
                      'addedAt': FieldValue.serverTimestamp(),
                    });
                  } else {
                    wishlistRef.doc(doc.docs.first.id).delete();
                  }
                },
                child: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  color: const Color(0xFF064E3C),
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
