import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/models/item_model.dart';
import 'package:greengrocer_course/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer_course/src/pages/product/product_screen.dart';
import 'package:greengrocer_course/src/routes/app_pages.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class ItemTile extends StatefulWidget {
  
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTile({ 
    Key? key, 
    required this.item, 
    required this.cartAnimationMethod
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGK = GlobalKey();

  final UtilServices utilServices = UtilServices();
  final cartController = Get.find<CartController>();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 2200));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Image.network(widget.item.imgUrl, key: imageGK)
                    )
                  ),
                  Text(widget.item.itemName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(utilServices.priceToCurrency(widget.item.price), style: TextStyle(fontSize: 20, color: CustomColors.customPrimaryColor, fontWeight: FontWeight.bold)),
                      Text('/${widget.item.unit}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold)),

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20)
            ),
            child: Material(
              child: InkWell(
                
                onTap: () {
                  switchIcon();

                  cartController.addItemToCart(item: widget.item);

                  widget.cartAnimationMethod(imageGK);
                  
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColors.customPrimaryColor,
                  ),
                  child: Icon(tileIcon, color: Colors.white, size: 20),
                ),
              ),
            ),
          ) 
        )
      ],
    );
  }
}