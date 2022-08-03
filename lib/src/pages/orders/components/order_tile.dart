import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/models/order_model.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {

  final OrderModel order;

  OrderTile({ 
    Key? key,
    required this.order
  }) : super(key: key);

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pedido: ${order.id}'),
              Text(utilServices.formatDateTime(order.cratedDateTime), style: TextStyle(fontSize: 12, color: Colors.black))
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            SizedBox(
              height: 100,
              child: _OrderItemWidget(order: order, utilServices: utilServices),
            )
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.order,
    required this.utilServices,
  }) : super(key: key);

  final OrderModel order;
  final UtilServices utilServices;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ListView(
              children: order.items.map((orderItem) {
                return Row(
                  children: [
                    Text('${orderItem!.quantity} ${orderItem.item.unit} ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(orderItem.item.itemName)
                    ),
                    Text(utilServices.priceToCurrency(orderItem.totalPrice()))
                  ],
                );
              }).toList(),
            )
          ),
          Expanded(
            flex: 2,
            child: Container()
          )
        ],
      ),
    );
  }
}