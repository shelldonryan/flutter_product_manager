import 'package:flutter_manager_product/app/interfaces/product_repository_interface.dart';
import 'package:flutter_manager_product/app/models/product.dart';
import 'package:mobx/mobx.dart';

part 'product_store.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  final IProductRepository productRepository;

  ProductStoreBase(this.productRepository);

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @action
  Future<void> getAllProducts() async {
    isLoading = true;
    final data = await productRepository.getAll();

    for (Product i in data) {
      products.add(i);
    }

    isLoading = false;
  }

}