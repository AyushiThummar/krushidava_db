// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'manage_products.dart';
import 'shopkeeper_details.dart';

class EditProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  children: [
                    // Back button with navigation
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
                          shadows: [
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

                    const SizedBox(width: 60),
                    // Title
                    const Text(
                      "Edit Product",
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

                    const SizedBox(width: 16),
                  ],
                ),
                const SizedBox(height: 20),

                // Update Product Image
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Update Product Image",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF064E3C),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              "Choose file",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/pesticide1.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Editable Fields
                buildField(
                  "Product Name",
                  "Liquid RAMBO-50 (CHLORPYRIFOS 50% EC)",
                ),
                const SizedBox(height: 20),
                buildField("Technical Name", "Chlorpyrifos 50% EC"),
                const SizedBox(height: 20),
                buildField("Packaging Size", "1 litre"),
                const SizedBox(height: 20),
                buildField("Packaging Type", "Bottle"),
                const SizedBox(height: 20),
                buildField("Brand", "ROMBO - 50"),
                const SizedBox(height: 30),

                // How to Use (editable)
                buildEditableBoxedSection(
                  title: "How to Use?",
                  text:
                      "Mix 2-3 ml per liter of water.\nSpray during early morning or evening.\nEnsure complete plant coverage.\nRepeat after 10-15 days if needed.\nAlways wear protective gear.",
                ),
                const SizedBox(height: 20),

                // Benefits (editable)
                buildEditableBoxedSection(
                  title: "Benefits",
                  text:
                      "Fast pest control within 24-48 hours.\nLong-lasting protection (10-15 days).\nCost-effective concentrated formula.\nSuitable for multiple crops.\nIncreases crop yield and quality.",
                ),
                const SizedBox(height: 20),

                // Availability Section
                AvailabilitySection(),
                const SizedBox(height: 20),

                // About Product Section
                AboutProductCheckboxSection(),
                const SizedBox(height: 40),

                // Update Button
                // Update Button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => ManageProducts()),
                      );
                    },
                    child: Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF064E3C),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Update Product",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Editable field
  Widget buildField(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "Poppins",
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF064E3C),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }

  // Editable boxed section
  Widget buildEditableBoxedSection({
    required String title,
    required String text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: text),
          maxLines: 6,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF064E3C),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}

// Availability Section
class AvailabilitySection extends StatefulWidget {
  @override
  _AvailabilitySectionState createState() => _AvailabilitySectionState();
}

class _AvailabilitySectionState extends State<AvailabilitySection> {
  String _availability = "In stock";
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
            Row(
              children: [
                Radio<String>(
                  value: "In stock",
                  groupValue: _availability,
                  activeColor: darkGreen,
                  onChanged: (value) => setState(() => _availability = value!),
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
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio<String>(
                  value: "Out of stock",
                  groupValue: _availability,
                  activeColor: darkGreen,
                  onChanged: (value) => setState(() => _availability = value!),
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

// About Product Section
class AboutProductCheckboxSection extends StatefulWidget {
  @override
  _AboutProductCheckboxSectionState createState() =>
      _AboutProductCheckboxSectionState();
}

class _AboutProductCheckboxSectionState
    extends State<AboutProductCheckboxSection> {
  final Color darkGreen = Color(0xFF064E3C);
  bool seasonalReChecked = true;
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
                  value: seasonalReChecked,
                  activeColor: darkGreen,
                  checkColor: Colors.white,
                  onChanged: (value) =>
                      setState(() => seasonalReChecked = value!),
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
                        fontSize: 16,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: recentlyAddedChecked,
                  activeColor: darkGreen,
                  checkColor: Colors.white,
                  onChanged: (value) =>
                      setState(() => recentlyAddedChecked = value!),
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
                        fontSize: 16,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: bestSellingChecked,
                  activeColor: darkGreen,
                  checkColor: Colors.white,
                  onChanged: (value) =>
                      setState(() => bestSellingChecked = value!),
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
                        fontSize: 16,
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
