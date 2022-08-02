import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/models/cart_item_model.dart';
import 'package:greengrocer_course/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';
import 'package:greengrocer_course/src/config/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({ Key? key }) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilServices utilServices = UtilServices();

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItem.remove(cartItem);
    });
  }

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
            child: ListView.builder(
              itemCount: app_data.cartItem.length,
              itemBuilder: (_, index) {
                return CartTile(
                  cartItem: app_data.cartItem[index],
                  remove: removeItemFromCart  
                );
              }
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
                Text(utilServices.priceToCurrency(cartTotalPrice()), style: TextStyle(color: CustomColors.customPrimaryColor, fontSize: 23, fontWeight: FontWeight.bold)),
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
                      print(result);
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