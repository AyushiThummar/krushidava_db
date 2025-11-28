import 'package:flutter/material.dart';
import 'product_details_farmer.dart';

class SeasonalRecommendations extends StatefulWidget {
  const SeasonalRecommendations({super.key});

  @override
  State<SeasonalRecommendations> createState() =>
      _SeasonalRecommendationsState();
}

class _SeasonalRecommendationsState extends State<SeasonalRecommendations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: Column(
          children: [
            /// --- Top Bar (Back Button + Title) ---
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
                        Navigator.pop(context);
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
                  const Text(
                    'Seasonal\nRecommendations',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF064E3C),
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// --- Product Cards Row ---
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First card
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // product image click
                            },
                            child: Container(
                              width: 125,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/pesticide1.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 125,
                            child: Text.rich(
                              TextSpan(
                                children: const [
                                  TextSpan(
                                    text: '50% EC CHLORPYRIPHOS\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'RAMBO-50\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '₹ 1000/LITRE',
                                    style: TextStyle(
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
                            children: [
                              GestureDetector(
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
                                  width: 80,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF008575),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
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

                      // Second card
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // product image click
                            },
                            child: Container(
                              width: 125,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/pesticide4.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 125,
                            child: Text.rich(
                              TextSpan(
                                children: const [
                                  TextSpan(
                                    text: 'IMIDACLOPRID 30.5% SC\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'IMIDOR PLUS\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '₹ 1,020/LITRE',
                                    style: TextStyle(
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
                            children: [
                              GestureDetector(
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
                                  width: 80,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF008575),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
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
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.favorite_border,
                                color: Color(0xFF064E3C),
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
