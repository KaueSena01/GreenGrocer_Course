import 'package:flutter/material.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/models/order_model.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {

  final OrderModel order;

  PaymentDialog({ 
    Key? key,
    required this.order 
  }) : super(key: key);

  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Pagamento com Pix', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                Text('Vencimento: ${utilServices.formatDateTime(order.overdueDateTime)}', 
                  style: const TextStyle(fontSize: 12),  
                ),
                Text('Total: ${utilServices.priceToCurrency(order.total)}', 
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),  
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    side: BorderSide(
                      width: 2,
                      color: CustomColors.customPrimaryColor
                    )
                  ),
                  onPressed: () {}, 
                  icon: const Icon(Icons.copy, size: 15), 
                  label: const Text('Copiar código Pix', style: TextStyle(fontSize: 13))
                )
              ],
            ),
          ),
          Positioned(
            top: -5,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)
            )
          )
        ],
      ),
    );
  }
}