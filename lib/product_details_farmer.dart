import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailsFarmer extends StatelessWidget {
  final String productId;
  const ProductDetailsFarmer({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Products')
              .doc(productId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("Product not found"));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;

            // Handle image
            Widget productImage;
            final imagePath = data['imagePath'] ?? '';
            if (imagePath.startsWith('/')) {
              productImage = Image.file(File(imagePath), fit: BoxFit.cover);
            } else if (imagePath.startsWith('http')) {
              productImage = Image.network(imagePath, fit: BoxFit.cover);
            } else {
              productImage = Image.asset(
                'assets/images/pesticide1.png',
                fit: BoxFit.cover,
              );
            }

            // Dynamic values
            final productName = data['name'] ?? '';
            final technicalName = data['technicalName'] ?? '';
            final packagingSize = data['packagingSize'] ?? '';
            final packagingType = data['packagingType'] ?? '';
            final brand = data['brand'] ?? '';
            final availability = data['availability'] ?? '';
            final howToUse = data['howToUse'] ?? '';
            final benefits = data['benefits'] ?? '';

            return SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1300,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(color: Color(0xFFE1FCF9)),
                  child: Stack(
                    children: [
                      // Product image
                      Positioned(
                        left: 35,
                        top: 92,
                        child: Container(
                          width: 125,
                          height: 250,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: productImage,
                          ),
                        ),
                      ),

                      // Wishlist button
                      Positioned(
                        right: 35,
                        top: 105,
                        child: Container(
                          width: 180,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Add to Wishlist',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Availability button
                      Positioned(
                        right: 35,
                        top: 193,
                        child: Container(
                          width: 180,
                          height: 37.84,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Availability',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Availability text
                      Positioned(
                        right: 150,
                        top: 243,
                        child: Text(
                          availability,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Product Name
                      Positioned(
                        left: 36,
                        top: 379,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 72,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 386,
                        child: SizedBox(
                          width: 200,
                          height: 27,
                          child: const Text(
                            'Product Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 432,
                        child: Text(
                          productName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Technical Name
                      Positioned(
                        left: 36,
                        top: 472,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 72,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 479,
                        child: SizedBox(
                          width: 228,
                          height: 27,
                          child: const Text(
                            'Technical Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 525,
                        child: Text(
                          technicalName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Packaging Size
                      Positioned(
                        left: 36,
                        top: 565,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 72,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 572,
                        child: SizedBox(
                          width: 208,
                          height: 27,
                          child: const Text(
                            'Packaging Size',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 618,
                        child: Text(
                          packagingSize,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Packaging Type
                      Positioned(
                        left: 36,
                        top: 658,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 72,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 665,
                        child: SizedBox(
                          width: 193,
                          height: 27,
                          child: const Text(
                            'Packaging Type',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 711,
                        child: Text(
                          packagingType,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Brand
                      Positioned(
                        left: 35,
                        top: 751,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 72,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 758,
                        child: SizedBox(
                          width: 136,
                          height: 27,
                          child: const Text(
                            'Brand',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 804,
                        child: Text(
                          brand,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // How to use
                      Positioned(
                        left: 36,
                        top: 844,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 72,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 851,
                        child: SizedBox(
                          width: 136,
                          height: 27,
                          child: const Text(
                            'How to use?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 56,
                        top: 897,
                        child: Text(
                          howToUse,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Benefits
                      Positioned(
                        left: 40,
                        top: 1021,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 80,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF064E3C),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        top: 1028,
                        child: SizedBox(
                          width: 136,
                          height: 27,
                          child: const Text(
                            'Benefits',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        top: 1074,
                        child: Text(
                          benefits,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Back button
                      Positioned(
                        left: 0,
                        top: -37,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 105,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE1FCF9),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 20,
                                top: 52,
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
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
