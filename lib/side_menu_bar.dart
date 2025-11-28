// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:krushidava/login_screen.dart';
import 'package:krushidava/seasonal_recommendations.dart';
import 'package:krushidava/best_selling_products.dart';
import 'package:krushidava/recently_added_stock.dart';
import 'package:krushidava/contact_details.dart';

class SideMenuBar extends StatelessWidget {
  final BuildContext parentContext;

  const SideMenuBar({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1FCF9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),

          _buildMenuItem(
            Icons.campaign,
            "Seasonal Recommendations",
            const SeasonalRecommendations(),
          ),
          _buildMenuItem(
            Icons.star,
            "Best Selling Products",
            const BestSellingProducts(),
          ),
          _buildMenuItem(
            Icons.new_releases,
            "Recently Added Stock",
            const RecentlyAddedStock(),
          ),
          _buildMenuItem(Icons.call, "Contact Us", const ContactDetailsPage()),

          const SizedBox(height: 50), // instead of Spacer, smaller gap

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins",
              ),
            ),
            onTap: () {
              Navigator.pop(parentContext);
              Navigator.pushAndRemoveUntil(
                parentContext,
                MaterialPageRoute(builder: (_) => Register()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, Widget page) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF064E3C)),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),
      ),
      onTap: () {
        Navigator.pop(parentContext);
        Navigator.push(parentContext, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}
