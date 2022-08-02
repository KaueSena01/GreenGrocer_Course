import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/models/item_model.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class ItemTile extends StatelessWidget {
  
  final ItemModel item;

  ItemTile({ Key? key, required this.item }) : super(key: key);

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
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
                  child: Image.asset(item.imgUrl)
                ),
                Text(item.itemName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text(utilServices.priceToCurrency(item.price), style: TextStyle(fontSize: 20, color: CustomColors.customPrimaryColor, fontWeight: FontWeight.bold)),
                    Text('/${item.unit}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold)),

                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              width: 35,
              decoration: BoxDecoration(
                color: CustomColors.customPrimaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(20)
                )
              ),
              child: const Icon(Icons.add_shopping_cart_outlined, color: Colors.white, size: 20),
            ),
          ) 
        )
      ],
    );
  }
}