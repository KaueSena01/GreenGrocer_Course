import 'package:greengrocer_course/src/models/item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;

  CartItemModel({
    required this.item,
    required this.quantity
  });

  totalPrice() => item.price * quantity;
}