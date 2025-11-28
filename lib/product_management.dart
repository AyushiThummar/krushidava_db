// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'manage_products.dart';
import 'shopkeeper_details.dart';

class ProductManagement extends StatelessWidget {
  const ProductManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final Color darkGreen = const Color(0xFF064E3C);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Back button
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
                    "Add New Product",
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
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

              // Upload Image
              const Text(
                'Upload Image Of New Product',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 150,
                height: 40,
                decoration: ShapeDecoration(
                  color: darkGreen,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Choose file',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Editable Input Fields
              buildEditableField('Product Name', 'Enter product name'),
              buildEditableField('Technical Name', 'Enter technical name'),
              buildEditableField('Packaging Size', 'Enter packaging size'),
              buildEditableField('Packaging Type', 'Enter packaging type'),
              buildEditableField('Brand', 'Enter brand'),

              // Large editable fields
              buildEditableLargeField(
                'How to Use?',
                'Enter how to use this product',
              ),
              buildEditableLargeField(
                'Benefits',
                'Enter benefits of using this product',
              ),

              const SizedBox(height: 20),

              // Availability Section
              AvailabilitySection(),

              const SizedBox(height: 20),

              // About Product Section
              AboutProductCheckboxSection(),

              const SizedBox(height: 30),

              // Upload Button
              Center(
                child: Container(
                  width: 220,
                  height: 49,
                  decoration: ShapeDecoration(
                    color: darkGreen,
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
                  alignment: Alignment.center,
                  child: const Text(
                    'Upload Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
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

  Widget buildEditableField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: const Color(0xFF064E3C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableLargeField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            maxLines: 6,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: const Color(0xFF064E3C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Radio Buttons Section
class AvailabilitySection extends StatefulWidget {
  @override
  _AvailabilitySectionState createState() => _AvailabilitySectionState();
}

class _AvailabilitySectionState extends State<AvailabilitySection> {
  String _availability = "In stock"; // default
  final Color darkGreen = Color(0xFF064E3C);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Availability",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            // In Stock
            Row(
              children: [
                Radio<String>(
                  value: "In stock",
                  groupValue: _availability,
                  activeColor: darkGreen,
                  onChanged: (value) {
                    setState(() => _availability = value!);
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "In stock",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Out of Stock
            Row(
              children: [
                Radio<String>(
                  value: "Out of stock",
                  groupValue: _availability,
                  activeColor: darkGreen,
                  onChanged: (value) {
                    setState(() => _availability = value!);
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Out of stock",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ✅ Checkbox Section
class AboutProductCheckboxSection extends StatefulWidget {
  @override
  _AboutProductCheckboxSectionState createState() =>
      _AboutProductCheckboxSectionState();
}

class _AboutProductCheckboxSectionState
    extends State<AboutProductCheckboxSection> {
  final Color darkGreen = Color(0xFF064E3C);

  bool seasonalChecked = true;
  bool recentlyAddedChecked = false;
  bool bestSellingChecked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About This Product",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: seasonalChecked,
                  activeColor: darkGreen,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() => seasonalChecked = value!);
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Seasonal Recommendations",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: recentlyAddedChecked,
                  activeColor: darkGreen,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() => recentlyAddedChecked = value!);
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Recently Added Stock",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: bestSellingChecked,
                  activeColor: darkGreen,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() => bestSellingChecked = value!);
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: darkGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Best Selling Product",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
