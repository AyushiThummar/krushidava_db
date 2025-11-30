import 'dart:io';
import 'package:flutter/material.dart';

class ProductDetailsFarmerDynamic extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsFarmerDynamic({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    final imagePath = productData['imagePath'] ?? '';

    /// ---- Image Handling ----
    Widget productImage;
    if (imagePath.startsWith('http')) {
      productImage = Image.network(imagePath, fit: BoxFit.cover);
    } else if (imagePath.startsWith('/') && File(imagePath).existsSync()) {
      productImage = Image.file(File(imagePath), fit: BoxFit.cover);
    } else {
      productImage = Image.asset(
        'assets/images/pesticide1.png',
        fit: BoxFit.cover,
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ---- Product Image ----
              SizedBox(
                height: 250,
                width: double.infinity,
                child: productImage,
              ),
              const SizedBox(height: 20),

              /// ---- Details ----
              InfoRow(title: "Product Name", value: productData['name'] ?? ''),
              InfoRow(
                title: "Technical Name",
                value: productData['technicalName'] ?? '',
              ),
              InfoRow(
                title: "Packaging Size",
                value: productData['packagingSize'] ?? '',
              ),
              InfoRow(
                title: "Packaging Type",
                value: productData['packagingType'] ?? '',
              ),
              InfoRow(title: "Brand", value: productData['brand'] ?? ''),
              InfoRow(
                title: "Availability",
                value: productData['availability'] ?? '',
              ),
              InfoRow(
                title: "How to use?",
                value: productData['howToUse'] ?? '',
              ),
              InfoRow(title: "Benefits", value: productData['benefits'] ?? ''),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---- Reusable Info Row ----
class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF064E3C),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
