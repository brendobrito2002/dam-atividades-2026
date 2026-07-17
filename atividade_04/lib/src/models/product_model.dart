import 'package:uuid/uuid.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final bool isFavorite;

  ProductModel({
    String? id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.category = 'Geral',
    this.isFavorite = false,
  }) : id = id ?? const Uuid().v4();

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? category,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
