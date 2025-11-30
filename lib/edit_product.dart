// edit_product.dart
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'manage_products.dart';
import 'shopkeeper_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProduct extends StatefulWidget {
  final String productId;
  const EditProduct({required this.productId});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final Color darkGreen = const Color(0xFF064E3C);

  // controllers
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

  // flags
  String _availability = "In stock";
  bool seasonalReChecked = true;
  bool recentlyAddedChecked = false;
  bool bestSellingChecked = true;

  // image handling
  File? _pickedImage; // newly picked (not yet saved)
  String? _existingImagePath; // existing saved path from Firestore

  bool _loadingInitial = true;
  bool _updating = false;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .get();
      final data = doc.data();
      if (data != null) {
        _nameController.text = (data['name'] ?? '') as String;
        _technicalNameController.text = (data['technicalName'] ?? '') as String;
        _packagingSizeController.text = (data['packagingSize'] ?? '') as String;
        _packagingTypeController.text = (data['packagingType'] ?? '') as String;
        _brandController.text = (data['brand'] ?? '') as String;
        _howToUseController.text = (data['howToUse'] ?? '') as String;
        _benefitsController.text = (data['benefits'] ?? '') as String;
        _availability = (data['availability'] ?? 'In stock') as String;
        seasonalReChecked = (data['seasonal'] ?? false) as bool;
        recentlyAddedChecked = (data['recentlyAdded'] ?? false) as bool;
        bestSellingChecked = (data['bestSelling'] ?? false) as bool;
        _existingImagePath = (data['imagePath'] ?? '') as String?;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading product: $e')));
    } finally {
      setState(() {
        _loadingInitial = false;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          _pickedImage = File(picked.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Future<String> _saveImageLocally(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'product_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = await imageFile.copy('${appDir.path}/$fileName');
    return savedFile.path;
  }

  Future<void> _updateProduct() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Product Name')),
      );
      return;
    }

    setState(() => _updating = true);

    try {
      String? imagePathToSave = _existingImagePath;

      // If user picked a new image, save it locally and delete old file if present
      if (_pickedImage != null) {
        final newPath = await _saveImageLocally(_pickedImage!);

        // delete old local file if exists and is different
        if (_existingImagePath != null && _existingImagePath!.isNotEmpty) {
          try {
            final oldFile = File(_existingImagePath!);
            if (await oldFile.exists()) {
              await oldFile.delete();
            }
          } catch (_) {
            // ignore delete errors
          }
        }

        imagePathToSave = newPath;
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
        "seasonal": seasonalReChecked,
        "recentlyAdded": recentlyAddedChecked,
        "bestSelling": bestSellingChecked,
        "imagePath": imagePathToSave,
        "date": DateTime.now(),
      };

      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update(productData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );

      // navigate back to ManageProducts (as your UI did)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ManageProducts()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating product: $e')));
    } finally {
      setState(() => _updating = false);
    }
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
    if (_loadingInitial) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final File? displayImageFile =
        _pickedImage ??
        (_existingImagePath != null && _existingImagePath!.isNotEmpty
            ? File(_existingImagePath!)
            : null);
    final bool exists =
        displayImageFile != null && displayImageFile.existsSync();

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
                          MaterialPageRoute(
                            builder: (_) => const ManageProducts(),
                          ),
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
                          shadows: const [
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
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
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
                        child: exists
                            ? Image.file(
                                displayImageFile,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
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
                buildField("Product Name", controller: _nameController),
                const SizedBox(height: 20),
                buildField(
                  "Technical Name",
                  controller: _technicalNameController,
                ),
                const SizedBox(height: 20),
                buildField(
                  "Packaging Size",
                  controller: _packagingSizeController,
                ),
                const SizedBox(height: 20),
                buildField(
                  "Packaging Type",
                  controller: _packagingTypeController,
                ),
                const SizedBox(height: 20),
                buildField("Brand", controller: _brandController),
                const SizedBox(height: 30),

                // How to Use (editable)
                buildEditableBoxedSection(
                  title: "How to Use?",
                  controller: _howToUseController,
                ),
                const SizedBox(height: 20),

                // Benefits (editable)
                buildEditableBoxedSection(
                  title: "Benefits",
                  controller: _benefitsController,
                ),
                const SizedBox(height: 20),

                // Availability Section
                AvailabilitySection(
                  availability: _availability,
                  onChanged: (val) => setState(() => _availability = val),
                ),
                const SizedBox(height: 20),

                // About Product Section
                AboutProductCheckboxSection(
                  seasonal: seasonalReChecked,
                  recentlyAdded: recentlyAddedChecked,
                  bestSelling: bestSellingChecked,
                  onChanged: (seasonal, recent, best) => setState(() {
                    seasonalReChecked = seasonal;
                    recentlyAddedChecked = recent;
                    bestSellingChecked = best;
                  }),
                ),
                const SizedBox(height: 40),

                // Update Button
                Center(
                  child: GestureDetector(
                    onTap: _updating ? null : _updateProduct,
                    child: Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF064E3C),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _updating
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
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

  // Editable field (uses provided controller)
  Widget buildField(String title, {required TextEditingController controller}) {
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
          controller: controller,
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

  // Editable boxed section (uses provided controller)
  Widget buildEditableBoxedSection({
    required String title,
    required TextEditingController controller,
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
          controller: controller,
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

// Availability Section (reusable, controlled from parent)
class AvailabilitySection extends StatefulWidget {
  final String availability;
  final ValueChanged<String> onChanged;
  const AvailabilitySection({
    required this.availability,
    required this.onChanged,
  });

  @override
  _AvailabilitySectionState createState() => _AvailabilitySectionState();
}

class _AvailabilitySectionState extends State<AvailabilitySection> {
  late String _availability;
  final Color darkGreen = const Color(0xFF064E3C);

  @override
  void initState() {
    super.initState();
    _availability = widget.availability;
  }

  @override
  void didUpdateWidget(covariant AvailabilitySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.availability != _availability) {
      _availability = widget.availability;
    }
  }

  void _onChange(String value) {
    setState(() => _availability = value);
    widget.onChanged(value);
  }

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
                  onChanged: (value) => _onChange(value!),
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
                  onChanged: (value) => _onChange(value!),
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

// About Product Section (reusable, controlled from parent)
class AboutProductCheckboxSection extends StatefulWidget {
  final bool seasonal;
  final bool recentlyAdded;
  final bool bestSelling;
  final void Function(bool seasonal, bool recentlyAdded, bool bestSelling)
  onChanged;

  const AboutProductCheckboxSection({
    required this.seasonal,
    required this.recentlyAdded,
    required this.bestSelling,
    required this.onChanged,
  });

  @override
  _AboutProductCheckboxSectionState createState() =>
      _AboutProductCheckboxSectionState();
}

class _AboutProductCheckboxSectionState
    extends State<AboutProductCheckboxSection> {
  late bool seasonalReChecked;
  late bool recentlyAddedChecked;
  late bool bestSellingChecked;
  final Color darkGreen = const Color(0xFF064E3C);

  @override
  void initState() {
    super.initState();
    seasonalReChecked = widget.seasonal;
    recentlyAddedChecked = widget.recentlyAdded;
    bestSellingChecked = widget.bestSelling;
  }

  @override
  void didUpdateWidget(covariant AboutProductCheckboxSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.seasonal != seasonalReChecked ||
        widget.recentlyAdded != recentlyAddedChecked ||
        widget.bestSelling != bestSellingChecked) {
      seasonalReChecked = widget.seasonal;
      recentlyAddedChecked = widget.recentlyAdded;
      bestSellingChecked = widget.bestSelling;
    }
  }

  void _notify() {
    widget.onChanged(
      seasonalReChecked,
      recentlyAddedChecked,
      bestSellingChecked,
    );
  }

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
                  onChanged: (value) {
                    setState(() => seasonalReChecked = value ?? false);
                    _notify();
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
                  onChanged: (value) {
                    setState(() => recentlyAddedChecked = value ?? false);
                    _notify();
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
                  onChanged: (value) {
                    setState(() => bestSellingChecked = value ?? false);
                    _notify();
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
