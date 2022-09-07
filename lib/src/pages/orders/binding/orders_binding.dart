import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:greengrocer_course/src/pages/orders/controller/all_orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }
}