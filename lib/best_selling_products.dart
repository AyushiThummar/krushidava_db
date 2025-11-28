import 'package:flutter/material.dart';
import 'product_details_farmer.dart';
import 'home.dart';

class BestSellingProducts extends StatelessWidget {
  const BestSellingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: Column(
          children: [
            /// --- Top Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 45,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  /// Title
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Best Selling Products',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF064E3C),
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Add more space before product cards
            const SizedBox(height: 40),

            /// --- Product Cards Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// First Product Card
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 140,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/pesticide1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'LIQUID BIO AGRICULTURAL \nPESTICIDES SPG\n₹ 2,000/LITRE',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProductDetailsFarmer(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF008575),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'Read more',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.favorite,
                          color: Color(0xFF064E3C),
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),

                /// Second Product Card
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 140,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/pesticide2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'UTTAM CHLOROPYRIPHOS\n1.5% DP, POUCH & BEG\n₹ 40/KG',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProductDetailsFarmer(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF008575),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'Read more',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.favorite,
                          color: Color(0xFF064E3C),
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
