import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/productsDetails.dart';
import '../Drawer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  Future<List<dynamic>> fetchProducts() async {
    final response =
    await http.get(Uri.parse('https://dummyjson.com/products'));
    final data = json.decode(response.body);
    return data['products'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
      drawer:  AppDrawer(),

      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No Products"));
          }

          final products = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                       builder: (_) =>
                           ProductDetailsScreen(product: p),
                     ),
                  );
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          p['thumbnail'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${p['price']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "-${p['discountPercentage']}%",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
