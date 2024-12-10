import 'package:flutter_manager_product/app/interfaces/http_client_interface.dart';

import '../interfaces/product_repository_interface.dart';
import '../models/product.dart';

class ProductRepository implements IProductRepository{
  final IHttpClient httpClient;
  
  ProductRepository(this.httpClient);

  @override
  Future<void> create(String productName, int quantity, double price) async {
    final response = await httpClient.post("http://10.0.2.2:5001/api/product/create",
        {
          "name": productName,
          "quantity": quantity,
          "price": price
        });

    if(!response.containsKey('success')) {
      throw Exception('Failed to create product: $response');
    }
  }

  @override
  Future<List<Product>> getAll() async {
    final response = await httpClient.get("http://10.0.2.2:5001/api/product/getByUser");

    List<Product> products = [];

    if (response['status'] == 'suceeded') {
      for (Map<String, dynamic> i in response['data']) {
        products.add(Product.fromMap(i));
      }
    }

    return products;
  }
}

