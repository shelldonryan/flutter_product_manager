abstract class IProductRepository {
  Future getAll();
  Future create(String productName, int quantity, double price);
}