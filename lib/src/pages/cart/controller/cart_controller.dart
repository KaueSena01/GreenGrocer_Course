import 'package:get/get.dart';
import 'package:greengrocer_course/src/models/cart_item_model.dart';
import 'package:greengrocer_course/src/models/item_model.dart';
import 'package:greengrocer_course/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer_course/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer_course/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class CartController extends GetxController {

  final cartRespository = CartRepostiroy();
  final authController = Get.find<AuthController>();
  final utilServices = UtilServices();
  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for(final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<void> getCartItems() async {
     final CartResult<List<CartItemModel>> result = await cartRespository.getCartItems(
      token: authController.user.token!, 
      userId: authController.user.id!
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();

        print(data);
      }, 
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true
        );
      }
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((ItemInList) => ItemInList.id == item.id);
  }

  Future<void> addItemCart({required ItemModel item, int quantity = 1}) async {

    int itemIndex = getItemIndex(item);

    if(itemIndex >= 0) {
      cartItems[itemIndex].quantity += quantity;


    } else {

      final CartResult<String> result = await cartRespository.addItemToCart(
        userId: authController.user.id!, 
        token: authController.user.token!, 
        productId: item.id,
        quantity: quantity
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(id: cartItemId, item: item, quantity: quantity)
          );
        }, 
        error: (message) {
          utilServices.showToast(
            message: message,
            isError: true
          );
        }
      );
    }

    update();

  }

}