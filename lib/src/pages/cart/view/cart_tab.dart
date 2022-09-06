import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/models/cart_item_model.dart';
import 'package:greengrocer_course/src/pages/cart/controller/cart_controller.dart'; 
import 'package:greengrocer_course/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';
import 'package:greengrocer_course/src/config/app_data.dart' as app_data;

import 'components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({ Key? key }) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilServices utilServices = UtilServices();

  double cartTotalPrice() {
    double total = 0;

    for(var item in app_data.cartItem) {
      total += item.totalPrice();
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>( 
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    return CartTile(
                      cartItem: controller.cartItems[index]
                    );
                  }
                ); 
              },
            )
          ), 
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Total geral', style: TextStyle(fontSize: 15)),
                GetBuilder<CartController>( 
                  builder: (controller) {
                    return Text(utilServices.priceToCurrency(controller.cartTotalPrice()), style: TextStyle(color: CustomColors.customPrimaryColor, fontSize: 23, fontWeight: FontWeight.bold)); 
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.customPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)
                      )
                    ),
                    onPressed: () async {
                      bool? result =  await showOrderConfirmation();
                      if(result ?? false) {
                        showDialog(
                          context: context, 
                          builder: (_) {
                            return PaymentDialog(
                              order: app_data.orders.first
                            );
                          }
                        );
                      } else {
                        utilServices.showToast(message: 'Pedido não confirmado', isError: true);
                      }
                    }, 
                    child: const Text('Concluir pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  ),
                )
              ],
            ),
         )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              }, 
              child: const Text('Não')
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              }, 
              child: const Text('Sim')
            )
          ],
        );
      }
    );
  }
}