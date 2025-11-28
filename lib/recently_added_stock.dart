import 'package:flutter/material.dart';
import 'product_details_farmer.dart';
import 'home.dart';

class RecentlyAddedStock extends StatefulWidget {
  const RecentlyAddedStock({super.key});

  @override
  State<RecentlyAddedStock> createState() => _RecentlyAddedStockState();
}

class _RecentlyAddedStockState extends State<RecentlyAddedStock> {
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
                      'Recently Added Stock',
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
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(
                          image: AssetImage('assets/images/pesticide1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'UTTAM',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' CHLOROPYRIPHOS\n1.5% DP, POUCH & BEG\n₹ 40/KG',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
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
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(
                          image: AssetImage('assets/images/pesticide2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'SPG',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                          TextSpan(
                            text: ' ORGANIC PESTICIDE\n500ml Bottle\n₹ 999',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
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
