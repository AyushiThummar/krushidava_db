// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:krushidava/home.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController addressController = TextEditingController(
    text: "--------------------",
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Green header with centered title
                Container(
                  width: double.infinity,
                  height: 260,
                  color: const Color(0xFF008575),
                  child: Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                // Back button → HomePage
                Positioned(
                  left: 25,
                  top: 45,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
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
                      child: const Center(
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                // User profile image
                Positioned(
                  top: 200,
                  left: screenWidth / 2 - 50,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            "assets/images/profile.png",
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: const Color(0xFF18B5A3),
                          child: Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 60),

            // Person name
            Text(
              'Person name',
              style: TextStyle(
                color: const Color(0xFF064E3C),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),

            SizedBox(height: 30),

            // Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  buildStyledField("Mobile Number", "+91 XXXXX XXXXX"),
                  SizedBox(height: 25),
                  buildStyledField("Email", "xyz111@gmail.com"),
                  SizedBox(height: 25),
                  buildStyledField(
                    "Address",
                    "",
                    isEditable: true,
                    showEdit: true,
                    controller: addressController,
                  ),
                  SizedBox(height: 50),

                  // Update Profile button → HomePage
                  Container(
                    width: 200,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF064E3C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Center(
                          child: Text(
                            'Update Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Logout button → LoginPage
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.logout, color: Colors.black, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStyledField(
    String label,
    String value, {
    bool showEdit = false,
    bool isEditable = false,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF064E3C),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
          ),
          child: Row(
            children: [
              // Editable text field
              Expanded(
                child: isEditable
                    ? TextField(
                        controller: controller,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      )
                    : Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                        maxLines: null,
                      ),
              ),
              if (showEdit)
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.edit, color: Colors.black54, size: 18),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
