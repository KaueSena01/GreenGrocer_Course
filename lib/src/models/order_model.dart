import 'package:greengrocer_course/src/models/cart_item_model.dart';

class OrderModel {
  String id;
  DateTime cratedDateTime;
  DateTime overdueDateTime;
  List<CartItemModel?> items;
  String status;
  String copyAndPaste;
  double total;

  OrderModel({
    required this.id,
    required this.cratedDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total
  });
}