import 'package:get/get.dart'; 
import 'package:greengrocer_course/src/constants/storage_keys.dart';
import 'package:greengrocer_course/src/models/user_model.dart';
import 'package:greengrocer_course/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer_course/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer_course/src/routes/app_pages.dart';
import 'package:greengrocer_course/src/services/utils_services.dart';

class AuthController extends GetxController {

  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilServices = UtilServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilServices.getLocalData(key: StorageKeys.token);

    if(token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      }, 
      error: (message) {
        signOut();
      }
    );
  }

  Future<void> signOut() async {
    // Atribuição nula
    user = UserModel();

    await utilServices.removeLocalData(key: StorageKeys.token);

    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    utilServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    // Requisição no Back
    AuthResult result = await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProceedToBase();
      }, 
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true
        );
        print(message);
      }
    );
  }

}