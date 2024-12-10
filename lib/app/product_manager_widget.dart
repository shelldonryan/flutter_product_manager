import 'package:flutter/material.dart';
import 'package:flutter_manager_product/app/Services/client_http_service.dart';
import 'package:flutter_manager_product/app/interfaces/http_client_interface.dart';
import 'package:provider/provider.dart';
import 'pages/auth/auth_page.dart';

class ProductManagerApp extends StatelessWidget {
  const ProductManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IHttpClient>(create: (context) => ClientHttpService()),
      ],
      child: const MaterialApp(
        title: "Products App",
        debugShowCheckedModeBanner: false,
        home: AuthenticationPage(),
      ),
    );
  }
}