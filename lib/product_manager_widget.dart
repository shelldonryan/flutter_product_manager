import 'package:flutter/material.dart';
import 'app/pages/auth/auth_page.dart';

class ProductManagerApp extends StatelessWidget {
  const ProductManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Products App",
      debugShowCheckedModeBanner: false,
      home: AuthenticationPage(),
    );
  }
}