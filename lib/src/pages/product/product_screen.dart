import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/models/item_model.dart';
import 'package:greengrocer_course/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocer_course/src/pages/common_widgets/quantity_widget.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({ Key? key, required this.item }) : super(key: key);

  final ItemModel item;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilServices utilServices = UtilServices();
  final navigationController = Get.find<NavigationController>();

  int cartItemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.item.imgUrl,
                  child: Image.network(widget.item.imgUrl)
                )
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50)
                    ),
                    boxShadow: [ 
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.itemName, 
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, 
                              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold)
                            ),
                          ),
                          QuantityWidget(
                            value: cartItemQuantity,
                            suffixText: widget.item.unit,
                            result: (int quantity) {
                              setState(() {
                                cartItemQuantity = quantity;
                              });
                            },
                          )
                        ],
                      ),
                      Text(utilServices.priceToCurrency(widget.item.price), style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: CustomColors.customPrimaryColor)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SingleChildScrollView(child: Text(widget.item.description * 10, style: const TextStyle(height: 1.5))
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                          onPressed: () {
                            Get.back();
                            navigationController.navigatePageView(NavigationTabs.cart);
                            
                          }, 
                          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                          label: const Text('Adicionar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios)
            ),
          )
        ],
      ),
    );
  }
}