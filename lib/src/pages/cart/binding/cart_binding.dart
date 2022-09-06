import 'package:get/get.dart';
import 'package:greengrocer_course/src/pages/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(CartController());
  }

}