// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product_details_farmer_dynamic.dart';
import 'home.dart';

class RecentlyAddedStock extends StatelessWidget {
  const RecentlyAddedStock({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- TOP BAR ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      ),
                      child: Container(
                        width: 45,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Recently Added Stock',
                      style: TextStyle(
                        color: Color(0xFF064E3C),
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ---------- GRID ----------
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where('recentlyAdded', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return const Center(child: CircularProgressIndicator());
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                    return const Center(
                      child: Text(
                        'No recently added products found',
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                    );

                  final products = snapshot.data!.docs;

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
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
                      if (imagePath.startsWith('http'))
                        productImage = Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                        );
                      else if (File(imagePath).existsSync())
                        productImage = Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
                        );

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
            ),
          ],
        ),
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
    required Map<String, dynamic> productData,
    required String productId,
    required String userId,
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsFarmerDynamic(productData: productData),
                  ),
                ),
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
                  final wishlistRef = FirebaseFirestore.instance.collection(
                    'wishlist',
                  );
                  final found = await wishlistRef
                      .where('userId', isEqualTo: userId)
                      .where('productId', isEqualTo: productId)
                      .get();
                  if (found.docs.isEmpty) {
                    wishlistRef.add({
                      'userId': userId,
                      'productId': productId,
                      'addedAt': FieldValue.serverTimestamp(),
                    });
                  } else {
                    wishlistRef.doc(found.docs.first.id).delete();
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
