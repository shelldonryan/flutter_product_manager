import 'package:flutter_manager_product/app/models/product.dart';
import 'package:flutter_manager_product/app/store/product_store.dart';

class HomeController {
  final ProductStore _productStore;

  HomeController(this._productStore);

  List<Product> get products => _productStore.products.toList();

  Future<void> getAllProducts() async {
    await _productStore.getAllProducts();
  }
}