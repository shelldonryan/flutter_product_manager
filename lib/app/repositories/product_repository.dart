import '../interfaces/product_repository_interface.dart';
import '../models/product.dart';

class ProductRepository implements IProductRepository{


  final List<Product> products = [
    Product(id: '1', name: 'Maracujá', quantity: 240, price: 1.45),
    Product(id: '2', name: 'Uva', quantity: 200, price: 3.45),
    Product(id: '3', name: 'Laranja', quantity: 560, price: 2.35),
    Product(id: '4', name: 'Banana', quantity: 240, price: 4.00),
    Product(id: '5', name: 'Abacaxi', quantity: 240, price: 7.80),
  ];

  @override
  Future<void> create() async {
  }

  @override
  Future<void> getAll() async {

  }


}

