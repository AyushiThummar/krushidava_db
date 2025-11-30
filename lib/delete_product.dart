// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteProduct extends StatefulWidget {
  final String productId;
  const DeleteProduct({required this.productId, super.key});

  @override
  _DeleteProductState createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  bool _loading = false;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final doc = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get();
    setState(() {
      _data = doc.data();
    });
  }

  Future<void> _delete() async {
    setState(() => _loading = true);
    try {
      if (_data != null) {
        final imagePath = _data!['imagePath'] as String?;
        // delete doc
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .delete();
        // delete local file if exists
        if (imagePath != null && imagePath.isNotEmpty) {
          final f = File(imagePath);
          if (await f.exists()) {
            await f.delete();
          }
        }
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Product deleted')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = _data?['name'] ?? 'this product';
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE1FCF9),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _data == null
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Delete "$name"?',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('This will remove the product permanently.'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: _loading ? null : _delete,
                            child: _loading
                                ? const CircularProgressIndicator()
                                : const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
