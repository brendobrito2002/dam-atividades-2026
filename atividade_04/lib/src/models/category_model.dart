import 'package:uuid/uuid.dart';

class CategoryModel {
  final String id;
  final String name;

  CategoryModel({
    String? id,
    required this.name,
  }) : id = id ?? const Uuid().v4();

  CategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
