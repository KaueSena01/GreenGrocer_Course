import 'package:greengrocer_course/src/constants/endpoints.dart';
import 'package:greengrocer_course/src/models/cart_item_model.dart';
import 'package:greengrocer_course/src/pages/cart/cart_result/cart_result.dart'; 
import 'package:greengrocer_course/src/services/http_manager.dart';

class CartRepostiroy {

  final _httpMenager = HttpManager();

  Future<CartResult<List<CartItemModel>>>  getCartItems({required String token, required String userId}) async {
    final result = await _httpMenager.restRequest(
      url: EndPoints.getCartItems, 
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token
      },
      body: {
        'user': userId
      } 
    );

    if(result['result'] != null) {
      List<CartItemModel> data = List<Map<String, dynamic>>.from(result['result'])
      .map(CartItemModel.fromJson)
      .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error('Erro ao recuperar os dados do carrinho');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity
  }) async {
    final result = await _httpMenager.restRequest(
      url: EndPoints.addItemToCart, 
      method: HttpMethods.post,
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId
      },
      headers: {
        'X-Parse-Session-Token': token
      }
    );

    if(result['result'] != null) {
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error('Não foi possível adicionar no carrinho');
    }
  } 
}