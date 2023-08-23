import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as double,
    );
  }

// Equatable vai nos auxiliar a comparar instancias de objetos.
//Equatable - instancias diferentes, porém com propriedades iguais serão "iguais". por isso o get props
  @override
  List<Object?> get props => [id, title, price];
}
