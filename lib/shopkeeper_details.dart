// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; // your login screen
import 'shopkeeper_dashboard.dart'; // keep this import — back button uses Dashboard()

class ShopkeeperDetails extends StatefulWidget {
  final String userId;
  const ShopkeeperDetails({required this.userId});

  @override
  _ShopkeeperDetailsState createState() => _ShopkeeperDetailsState();
}

class _ShopkeeperDetailsState extends State<ShopkeeperDetails> {
  // Controllers for editable fields (preserve UI)
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _shopNameCtrl = TextEditingController();
  final TextEditingController _shopAddressCtrl = TextEditingController();
  final TextEditingController _licenseCtrl = TextEditingController();

  File? _profileImage;
  String? _savedImagePath; // local file path
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _shopNameCtrl.dispose();
    _shopAddressCtrl.dispose();
    _licenseCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      final data = snap.data();
      if (data != null) {
        _nameCtrl.text = (data['name'] ?? '') as String;
        _phoneCtrl.text = (data['phone'] ?? '') as String;
        _emailCtrl.text = (data['email'] ?? '') as String;
        _addressCtrl.text = (data['address'] ?? '') as String;
        _shopNameCtrl.text = (data['shopName'] ?? '') as String;
        _shopAddressCtrl.text = (data['shopAddress'] ?? '') as String;
        _licenseCtrl.text = (data['licenseNumber'] ?? '') as String;

        // Support both remote url (profilePhoto) and local path (imagePath)
        final imagePath = (data['imagePath'] ?? '') as String;
        final profilePhoto = (data['profilePhoto'] ?? '') as String;

        if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
          _savedImagePath = imagePath;
          _profileImage = File(imagePath);
        } else if (profilePhoto.isNotEmpty) {
          // leave _profileImage null but we will show NetworkImage later
          _savedImagePath = null;
        } else {
          _savedImagePath = null;
        }
      }
    } catch (e) {
      // fail silently; you can show a SnackBar if desired
      debugPrint('Error loading user data: $e');
    } finally {
      setState(() {});
    }
  }

  // Pick image from gallery (same UX as AddAnnouncement)
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final File pickedFile = File(picked.path);

    // Save locally to app documents dir (like AddAnnouncement)
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final saved = await pickedFile.copy('${appDir.path}/$fileName');

      setState(() {
        _profileImage = saved;
        _savedImagePath = saved.path;
      });
    } catch (e) {
      debugPrint('Error saving picked image locally: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image locally: $e')),
      );
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _loading = true);

    try {
      final updateMap = <String, dynamic>{
        'name': _nameCtrl.text.trim(),
        'phone': _phoneCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'address': _addressCtrl.text.trim(),
        'shopName': _shopNameCtrl.text.trim(),
        'shopAddress': _shopAddressCtrl.text.trim(),
        'licenseNumber': _licenseCtrl.text.trim(),
      };

      if (_savedImagePath != null && _savedImagePath!.isNotEmpty) {
        updateMap['imagePath'] = _savedImagePath;
        // keep backward compatibility: also set profilePhoto empty
        updateMap['profilePhoto'] = '';
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update(updateMap);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      debugPrint('Update error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update failed: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    // navigate to login screen (replace stack)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => Register()),
      (route) => false,
    );
  }

  // Reusable field widget matching your style
  Widget buildField(
    String label,
    TextEditingController controller, {
    bool isMultiline = false,
    bool hasEdit = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE1FCF9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: isMultiline
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    maxLines: isMultiline ? null : 1,
                    style: const TextStyle(
                      color: Color(0xFF383F3E),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (hasEdit)
                  const Icon(Icons.edit, size: 18, color: Colors.black54),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build the avatar ImageProvider: local file > network url > asset
  ImageProvider _avatarImageProvider(Map<String, dynamic>? userData) {
    if (_profileImage != null)
      return FileImage(_profileImage!) as ImageProvider;

    // prefer local 'imagePath' saved in Firestore
    final imagePath = (userData?['imagePath'] ?? '') as String;
    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      return FileImage(File(imagePath));
    }

    // fallback to network 'profilePhoto' if present
    final profilePhoto = (userData?['profilePhoto'] ?? '') as String;
    if (profilePhoto.isNotEmpty) {
      return NetworkImage(profilePhoto);
    }

    // final fallback asset
    return const AssetImage('assets/images/profile.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF008575),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final userData = snapshot.data!.data();

          // if controllers are empty but data exists, ensure they're filled (handles cold loads)
          // (we already load in initState, but this keeps UI consistent with future builds)
          // note: we avoid overwriting user's ongoing edits by checking if empty.
          if ((userData != null) && _nameCtrl.text.isEmpty) {
            _nameCtrl.text = (userData['name'] ?? '') as String;
            _phoneCtrl.text = (userData['phone'] ?? '') as String;
            _emailCtrl.text = (userData['email'] ?? '') as String;
            _addressCtrl.text = (userData['address'] ?? '') as String;
            _shopNameCtrl.text = (userData['shopName'] ?? '') as String;
            _shopAddressCtrl.text = (userData['shopAddress'] ?? '') as String;
            _licenseCtrl.text = (userData['licenseNumber'] ?? '') as String;
            // if imagePath exists and we haven't loaded it yet:
            final imgPath = (userData['imagePath'] ?? '') as String;
            final profilePhoto = (userData['profilePhoto'] ?? '') as String;
            if (_profileImage == null) {
              if (imgPath.isNotEmpty && File(imgPath).existsSync()) {
                _profileImage = File(imgPath);
                _savedImagePath = imgPath;
              } else if (profilePhoto.isNotEmpty) {
                _savedImagePath = null;
              }
            }
          }

          return Stack(
            children: [
              // White card
              Positioned(
                top: 180,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        buildField("Name", _nameCtrl),
                        buildField("Mobile No.", _phoneCtrl),
                        buildField("Email", _emailCtrl),
                        buildField("Address", _addressCtrl, isMultiline: true),
                        buildField("Shop Name", _shopNameCtrl),
                        buildField(
                          "Shop Address",
                          _shopAddressCtrl,
                          isMultiline: true,
                        ),
                        buildField("License No.", _licenseCtrl),
                        const SizedBox(height: 30),

                        GestureDetector(
                          onTap: _updateProfile,
                          child: Container(
                            width: 220,
                            height: 49,
                            decoration: BoxDecoration(
                              color: const Color(0xFF064E3C),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: _loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Update Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        GestureDetector(
                          onTap: () async {
                            await _logout();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout, color: Colors.black, size: 22),
                              SizedBox(width: 8),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              // Top bar (BACK BUTTON unchanged)
              Positioned(
                top: 50,
                left: 20,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // keep back button behavior exactly as before
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
                          // note: original used "shadows" previously; keep consistent look
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 45),
                  ],
                ),
              ),

              // Avatar + Camera
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: _avatarImageProvider(userData),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
