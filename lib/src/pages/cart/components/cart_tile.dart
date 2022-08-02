import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/models/cart_item_model.dart';
import 'package:greengrocer_course/src/pages/common_widgets/quantity_widget.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class CartTile extends StatefulWidget {

  final CartItemModel cartItem;
  final Function(CartItemModel) remove;

  CartTile({ 
    Key? key,
    required this.cartItem,
    required this.remove
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: ListTile(
        leading: Image.asset(widget.cartItem.item.imgUrl, height: 60, width: 60),
        title: Text(widget.cartItem.item.itemName, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(utilServices.priceToCurrency(widget.cartItem.totalPrice()), style: TextStyle(color: CustomColors.customPrimaryColor, fontWeight: FontWeight.bold)),
        trailing: QuantityWidget(
          value: widget.cartItem.quantity, 
          suffixText: widget.cartItem.item.unit, 
          isRemovable: true,
          result: (int quantity) {
            setState(() {
              widget.cartItem.quantity = quantity;

              if(quantity == 0) {
                widget.remove(widget.cartItem);
              }
            });
          }
        ),
      ),
    );
  }
}