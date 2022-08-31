import 'package:get/get.dart';
import 'package:greengrocer_course/src/config/app_data.dart';
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

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    // Requisição no Back
    AuthResult result = await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        Get.offAllNamed(PagesRoutes.baseRoute);
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