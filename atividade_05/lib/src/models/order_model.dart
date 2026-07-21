import 'package:uuid/uuid.dart';
import 'client_model.dart';
import 'product_model.dart';

class OrderItem {
  final ProductModel product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  });

  double get total => product.price * quantity;
}

class OrderModel {
  final String id;
  final ClientModel client;
  final List<OrderItem> items;
  final DateTime date;

  OrderModel({
    String? id,
    required this.client,
    required this.items,
    DateTime? date,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.total);
  }

  OrderModel copyWith({
    String? id,
    ClientModel? client,
    List<OrderItem>? items,
    DateTime? date,
  }) {
    return OrderModel(
      id: id ?? this.id,
      client: client ?? this.client,
      items: items ?? this.items,
      date: date ?? this.date,
    );
  }
}
