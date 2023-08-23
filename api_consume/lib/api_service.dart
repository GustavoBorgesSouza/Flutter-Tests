import 'package:api_consume/product.dart';
import 'package:uno/uno.dart';

class APIService {
  final Uno uno;

  APIService(this.uno);

  Future<List<Product>> getProducts() async {
    try {
      final response = await uno.get('/product');
      final list = response.data as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on UnoError catch (e) {
      return [];
    }
  }
}
