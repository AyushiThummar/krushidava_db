import 'package:flutter/material.dart';
import 'package:krushidava/farmer_profile.dart';
import 'side_menu_bar.dart';
import 'announcement.dart';
import 'wishlist.dart';
import 'feedback.dart';
import 'inquiry.dart';
import 'product_details_farmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      drawer: Drawer(child: SideMenuBar(parentContext: context)),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1FCF9),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF064E3C), size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 30,
        title: const Text(
          'Krushi Dava',
          style: TextStyle(
            color: Color(0xFF064E3C),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF064E3C),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Announcement()),
              );
            },
          ),
          const SizedBox(width: 1), // spacing between the two icons
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Color(0xFF064E3C),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
          ),
          const SizedBox(width: 30), // space from the right edge
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 35, color: Color(0xFF064E3C)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Wishlist()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.chat_bubble_outline,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FeedbackPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.help_outline,
                size: 35,
                color: Color(0xFF064E3C),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Inquiry()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.65,
              children: [
                _buildProductCard(
                  context,
                  image: 'assets/images/pesticide1.png',
                  title: '50% EC CHLORPYRIPHOS',
                  subtitle: 'RAMBO-50',
                  price: '₹ 1000/LITRE',
                  liked: true,
                  navigateToDetails: true,
                ),
                _buildProductCard(
                  context,
                  image: 'assets/images/pesticide2.png',
                  title: 'UTTAM CHLOROPYRIPHOS',
                  subtitle: '1.5% DP, POUCH & BEG',
                  price: '₹ 40/',
                  liked: true,
                ),
                _buildProductCard(
                  context,
                  image: 'assets/images/pesticide3.png',
                  title: 'IMIDACLOPRID 30.5% SC',
                  subtitle: 'CONFIDOR',
                  price: '₹ 1200/LITRE',
                  liked: false,
                ),
                _buildProductCard(
                  context,
                  image: 'assets/images/pesticide4.png',
                  title: 'ACETAMIPRID 20% SP',
                  subtitle: 'ACETA GOLD',
                  price: '₹ 900/KG',
                  liked: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
    required String price,
    required bool liked,
    bool navigateToDetails = false,
  }) {
    return Column(
      children: [
        Container(
          width: 140,
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 140,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: "$subtitle ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: price,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (navigateToDetails) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductDetailsFarmer(),
                    ),
                  );
                }
              },
              child: Container(
                width: 80,
                height: 20,
                decoration: ShapeDecoration(
                  color: const Color(0xFF008575),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Read more',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xFF064E3C),
              size: 18,
            ),
          ],
        ),
      ],
    );
  }
}
