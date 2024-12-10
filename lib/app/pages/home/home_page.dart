import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../repositories/product_repository.dart';
import '../../utils/my_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late final ProductRepository productRepository;

  @override
  void initState() {
    super.initState();
    productRepository = ProductRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.redFla,
        foregroundColor: Colors.white,
        title: const Text("Products"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: MyColors.redFla),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("logout"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: productRepository.products.length,
            itemBuilder: (context, index) {
              final product = productRepository.products[index];
              return Card(
                color: Colors.white,
                borderOnForeground: true,
                elevation: 1,
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.quantity.toString()),
                  trailing: Text(real.format(product.price)),
                ),
              );
            }),
      ),
    );
  }
}
