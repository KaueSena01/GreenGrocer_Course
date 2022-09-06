import 'package:greengrocer_course/src/constants/endpoints.dart'; 
import 'package:greengrocer_course/src/models/category_model_up.dart';
import 'package:greengrocer_course/src/models/item_model.dart';
import 'package:greengrocer_course/src/pages/home/result/home_result.dart'; 
import 'package:greengrocer_course/src/services/http_manager.dart';

class HomeRepository{

  final HttpManager _httpMenager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {

    final result = await _httpMenager.restRequest(
      url: EndPoints.getAllCategories, 
      method: HttpMethods.post
    );

    if(result['result'] != null) {

      List<CategoryModel> data = (List<Map<String, dynamic>>.from(result['result']))
      .map(CategoryModel.fromJson)
      .toList();

      return HomeResult<CategoryModel>.success(data);

    } else {
      return HomeResult.error('Ocorreu um erro inesperado');
    }

  }

  Future<HomeResult<ItemModel>> getAllProducts(Map<String, dynamic> body) async {

    final result = await _httpMenager.restRequest(
      url: EndPoints.getAllProducts,
      method: HttpMethods.post,
      body: body
    );

    if(result['result'] != null) {
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
        .map(ItemModel.fromJson)
        .toList();

        print(data);

        return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error('Ocorreu um erro inesperado');
    }
  }

}