import 'package:get/get.dart';
import 'package:greengrocer_course/src/models/category_model_up.dart'; 
import 'package:greengrocer_course/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer_course/src/pages/home/result/home_result.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class HomeController extends GetxController {
  
  final homeRepository = HomeRepository();
  final utilServices = UtilServices();

  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  void setLoading(bool value) {
    isLoading = value;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
  }

  Future<void> getAllCategories() async {

    setLoading(true);

    HomeResult<CategoryModel> homeResult = await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data) {

        allCategories.assignAll(data);

        if(allCategories.isEmpty) return;

        selectCategory(allCategories.first);

      }, 
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true
        );
      }
    );
  }

}