// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'manage_products.dart';
import 'shopkeeper_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  final Color darkGreen = const Color(0xFF064E3C);

  // Controllers for product fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _technicalNameController =
      TextEditingController();
  final TextEditingController _packagingSizeController =
      TextEditingController();
  final TextEditingController _packagingTypeController =
      TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _howToUseController = TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();

  // Availability & About toggles
  String _availability = "In stock";
  bool seasonalChecked = true;
  bool recentlyAddedChecked = false;
  bool bestSellingChecked = true;

  // Local image file selected for the product
  File? _selectedImage;
  bool _loading = false;

  // Pick image from gallery
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  // Save image to local app directory and return saved path
  Future<String> _saveImageLocally(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'product_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await imageFile.copy('${appDir.path}/$fileName');
    return savedFile.path;
  }

  // Create product in Firestore
  Future<void> _saveProduct() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Product Name')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      String? imagePathToSave;
      if (_selectedImage != null) {
        imagePathToSave = await _saveImageLocally(_selectedImage!);
      }

      final productData = {
        "name": _nameController.text.trim(),
        "technicalName": _technicalNameController.text.trim(),
        "packagingSize": _packagingSizeController.text.trim(),
        "packagingType": _packagingTypeController.text.trim(),
        "brand": _brandController.text.trim(),
        "howToUse": _howToUseController.text.trim(),
        "benefits": _benefitsController.text.trim(),
        "availability": _availability,
        "seasonal": seasonalChecked,
        "recentlyAdded": recentlyAddedChecked,
        "bestSelling": bestSellingChecked,
        "imagePath": imagePathToSave,
        "date": DateTime.now(),
      };

      await FirebaseFirestore.instance.collection('products').add(productData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );

      _clearForm();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  // Clear form
  void _clearForm() {
    setState(() {
      _nameController.clear();
      _technicalNameController.clear();
      _packagingSizeController.clear();
      _packagingTypeController.clear();
      _brandController.clear();
      _howToUseController.clear();
      _benefitsController.clear();
      _availability = "In stock";
      seasonalChecked = true;
      recentlyAddedChecked = false;
      bestSellingChecked = true;
      _selectedImage = null;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _technicalNameController.dispose();
    _packagingSizeController.dispose();
    _packagingTypeController.dispose();
    _brandController.dispose();
    _howToUseController.dispose();
    _benefitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UI preserved from your original code
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
                        MaterialPageRoute(
                          builder: (_) => const ManageProducts(),
                        ),
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

              // Upload Image - make tappable to pick image
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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 150,
                  height: 120,
                  decoration: ShapeDecoration(
                    color: darkGreen,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: _selectedImage == null
                      ? const Text(
                          'Choose file',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          width: 150,
                          height: 120,
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Editable Input Fields
              buildEditableField(
                'Product Name',
                'Enter product name',
                _nameController,
              ),
              buildEditableField(
                'Technical Name',
                'Enter technical name',
                _technicalNameController,
              ),
              buildEditableField(
                'Packaging Size',
                'Enter packaging size',
                _packagingSizeController,
              ),
              buildEditableField(
                'Packaging Type',
                'Enter packaging type',
                _packagingTypeController,
              ),
              buildEditableField('Brand', 'Enter brand', _brandController),

              // Large editable fields
              buildEditableLargeField(
                'How to Use?',
                'Enter how to use this product',
                _howToUseController,
              ),
              buildEditableLargeField(
                'Benefits',
                'Enter benefits of using this product',
                _benefitsController,
              ),

              const SizedBox(height: 20),

              // Availability Section
              Column(
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
              ),

              const SizedBox(height: 20),

              // About Product Checkboxes
              Column(
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
                              setState(() => seasonalChecked = value ?? false);
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
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: recentlyAddedChecked,
                            activeColor: darkGreen,
                            checkColor: Colors.white,
                            onChanged: (value) {
                              setState(
                                () => recentlyAddedChecked = value ?? false,
                              );
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
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: bestSellingChecked,
                            activeColor: darkGreen,
                            checkColor: Colors.white,
                            onChanged: (value) {
                              setState(
                                () => bestSellingChecked = value ?? false,
                              );
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
              ),

              const SizedBox(height: 30),

              // Upload Button (Create)
              Center(
                child: InkWell(
                  onTap: _loading ? null : _saveProduct,
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
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
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
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widgets adapted from your original functions but wired to controllers
  Widget buildEditableField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
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
            controller: controller,
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

  Widget buildEditableLargeField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
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
            controller: controller,
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
