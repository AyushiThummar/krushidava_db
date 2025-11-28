// ignore_for_file: use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class ContactDetailsPage extends StatelessWidget {
  /// Optional: pass a specific shopkeeper doc id when navigating:
  /// ContactDetailsPage(shopkeeperId: 'abc123');
  final String? shopkeeperId;

  const ContactDetailsPage({super.key, this.shopkeeperId});

  @override
  Widget build(BuildContext context) {
    // We'll listen to the whole collection so we can pick the right doc or fallback.
    final coll = FirebaseFirestore.instance.collection('contactDetails');

    return Scaffold(
      backgroundColor: const Color(0xFFDFF7F9),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: coll.snapshots(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snap.hasData || snap.data!.docs.isEmpty) {
              // No shopkeepers saved at all
              return Column(
                children: [
                  // Top bar (unchanged)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
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
                        const Text(
                          'Krushi Dava',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Color(0xFF064E3C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'No contactDetails documents found in Firestore.',
                    ),
                  ),
                ],
              );
            }

            // We have at least one document. Choose which doc to use:
            QueryDocumentSnapshot? chosenDoc;

            // 1) If caller supplied shopkeeperId, try to find it
            if (shopkeeperId != null && shopkeeperId!.isNotEmpty) {
              try {
                chosenDoc = snap.data!.docs.firstWhere(
                  (d) => d.id == shopkeeperId,
                );
              } catch (_) {
                chosenDoc = null;
              }
            }

            // 2) If not found, try to find a document whose id equals current user uid
            //    (useful when signed-in user is the shopkeeper).
            if (chosenDoc == null) {
              final currentUid =
                  FirebaseFirestore.instance.app.name == 'default'
                  ? null
                  : null; // placeholder — we will attempt to find by no UID here below
              // better approach: try to match by known field values if needed
              // but we will simply fall back to first doc if no explicit match
            }

            // 3) If still null, use first document as fallback (so farmer sees something)
            chosenDoc ??= snap.data!.docs.first;

            // Debug: print which doc we used
            debugPrint('ContactDetailsPage using doc id: ${chosenDoc.id}');

            // Convert data safely
            final raw = chosenDoc.data();
            final Map<String, dynamic> data = (raw == null)
                ? <String, dynamic>{}
                : Map<String, dynamic>.from(raw as Map<String, dynamic>);

            // Use null-aware defaults for fields (handles null in Firestore)
            final name = (data['name'] as String?) ?? 'Name surname';
            final time = (data['time'] as String?) ?? '8:00 AM to 10:00 PM';
            final mobile = (data['mobile'] as String?) ?? '+91xxxx xxxx';
            final whatsapp = (data['whatsapp'] as String?) ?? '+91xxxx xxxx';
            final address =
                (data['address'] as String?) ?? 'Address not provided';

            // --- THE ORIGINAL UI (unchanged) ---
            return Column(
              children: [
                /// --- Top Bar (Back Button + Title) ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
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
                      const Text(
                        'Krushi Dava',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Color(0xFF064E3C),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// --- Profile Row ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 33,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            time,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromARGB(255, 13, 13, 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// --- Contact Details Box ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Contact Title
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.contact_page,
                                color: Color(0xFF064E3C),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Contact Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// Phone number 1
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_android,
                              color: Color(0xFF064E3C),
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              mobile,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// Phone number 2
                        Row(
                          children: [
                            const Icon(
                              Icons.chat,
                              color: Color(0xFF064E3C),
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              whatsapp,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// Location
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: Colors.redAccent,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                address,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
