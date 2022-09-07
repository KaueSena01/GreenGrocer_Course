import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer_course/src/models/order_model.dart';
import 'package:greengrocer_course/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer_course/src/pages/orders/controller/order_controller.dart';
import 'package:greengrocer_course/src/pages/orders/view/components/order_status_widget.dart'; 
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
        child: GetBuilder<OrderController>(
          init: OrderController(order),
          global: false,
          builder: (controller) {
            return ExpansionTile(
              onExpansionChanged: (value) {
                if(value && order.items.isEmpty) {
                  controller.getOrderItems();
                }
              },
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              // initiallyExpanded: order.status == 'pending_payment',
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Pedido: ${order.id}'),
                  Text(utilServices.formatDateTime(order.cratedDateTime!), style: TextStyle(fontSize: 12, color: Colors.black))
                ],
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                _OrderItemWidget(order: order, utilServices: utilServices)
              ],
            );
          },
        )
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 150,
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
                    ),
                  )
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: OrderStatusWidgets(
                    status: order.status,
                    isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                  )
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 20),
              children: [
                const TextSpan(text: 'Total: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: utilServices.priceToCurrency(order.total))
              ]
            ),
          ),
          Visibility(
            visible: 
              order.status == 'pending_payment' 
              && !order.isOverDue,
            // replacement: , Outro Widget para apresentar
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (_) {
                    return PaymentDialog(
                      order: order,
                    );
                  }
                );
              }, 
              icon: Image.asset('assets/app_images/pix.png', height: 20),
              label: const Text('Ver QR Code Pix')
            ),
          )
        ],
      ),
    );
  }
}