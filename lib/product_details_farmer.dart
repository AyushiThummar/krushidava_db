import 'package:flutter/material.dart';

class ProductDetailsFarmer extends StatelessWidget {
  const ProductDetailsFarmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1FCF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(
                context,
              ).size.width, // ✅ take full screen width
              height: 1300,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFFE1FCF9)),
              child: Stack(
                children: [
                  Positioned(
                    left: 35,
                    top: 92,
                    child: Container(
                      width: 125,
                      height: 250,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/pesticide1.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 35,
                    top: 105,
                    child: Container(
                      width: 180,
                      height: 35,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Add to Wishlist',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 35,
                    top: 193,
                    child: Container(
                      width: 180,
                      height: 37.84,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Availability',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 150,
                    top: 243,
                    child: Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 379,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 386,
                    child: SizedBox(
                      width: 200,
                      height: 27,
                      child: Text(
                        'Product  Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 432,
                    child: Text(
                      'Liquid RAMBO-50 (CHLORPYRIFOS 50% EC)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 472,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 479,
                    child: SizedBox(
                      width: 228,
                      height: 27,
                      child: Text(
                        'Technical Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 525,
                    child: Text(
                      'Chlorpyrifos 50% EC',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 565,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 572,
                    child: SizedBox(
                      width: 208,
                      height: 27,
                      child: Text(
                        'Packaging Size',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 618,
                    child: Text(
                      '1 litre',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 658,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 665,
                    child: SizedBox(
                      width: 193,
                      height: 27,
                      child: Text(
                        'Packaging Type',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 711,
                    child: Text(
                      'Bottle',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 751,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 55,
                    top: 758,
                    child: SizedBox(
                      width: 136,
                      height: 27,
                      child: Text(
                        'Brand',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 55,
                    top: 804,
                    child: Text(
                      'ROMBO - 50',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 844,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 851,
                    child: SizedBox(
                      width: 136,
                      height: 27,
                      child: Text(
                        'How to use?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 897,
                    child: Text(
                      'Mix 2-3 ml per liter of water.\nSpray during early morning or evening.\nEnsure complete plant coverage.\nRepeat after 10-15 days if needed.\nAlways wear protective gear.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 1021,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF064E3C),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 60,
                    top: 1028,
                    child: SizedBox(
                      width: 136,
                      height: 27,
                      child: Text(
                        'Benefits',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 60,
                    top: 1074,
                    child: Text(
                      'Fast pest control within 24-48 hours.\nLong-lasting protection (10-15 days).\nCost-effective concentrated formula.\nSuitable for multiple crops.\nIncreases crop yield and quality.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: -37,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 105,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(color: Color(0xFFE1FCF9)),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 52,
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
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
