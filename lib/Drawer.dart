import 'package:flutter/material.dart';
import '../productscreen.dart';
import '../contactUsScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Flutter Store",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("store@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.store,
                color: Colors.teal,
                size: 40,
              ),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.teal),
            title: const Text("Products"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProductsScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.teal),
            title: const Text("Contact Us"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ContactUsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}