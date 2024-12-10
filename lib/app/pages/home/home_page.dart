import 'package:flutter/material.dart';
import 'package:flutter_manager_product/app/pages/home/home_controller.dart';
import 'package:flutter_manager_product/app/store/product_store.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../interfaces/http_client_interface.dart';
import '../../repositories/product_repository.dart';
import '../../utils/my_colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _homeController = HomeController(
      ProductStore(
        ProductRepository(
          context.watch<IHttpClient>(),
        ),
      ),
    );
    _homeController.getAllProducts();

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
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("logout"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Observer(
        builder: (_) => Container(
          padding: const EdgeInsets.all(10),
          child: _homeController.products.isEmpty
              ? const Center(
                  child: Text('No products available'),
                )
              : ListView.builder(
                  itemCount: _homeController.products.length,
                  itemBuilder: (context, index) {
                    final product = _homeController.products[index];
                    return Card(
                      color: Colors.white,
                      borderOnForeground: true,
                      elevation: 1,
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text('Quantity: ${product.quantity}'),
                        trailing: Text(real.format(product.price)),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
