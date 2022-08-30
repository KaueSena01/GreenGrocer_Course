import 'package:get/get.dart';
import 'package:greengrocer_course/src/pages/auth/repository/auth_repository.dart';

class AuthController extends GetxController {

  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    // Requisição no Back
    await authRepository.signIn(email: email, password: password);

    isLoading.value = false;
  }

}