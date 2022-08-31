import 'package:greengrocer_course/src/constants/endpoints.dart';
import 'package:greengrocer_course/src/models/user_model.dart';
import 'package:greengrocer_course/src/pages/auth/repository/auth_erros.dart' as authError;
import 'package:greengrocer_course/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer_course/src/services/http_manager.dart';

class AuthRepository {

  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> signIn({
    required String email,
    required String password
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.signin, 
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password
      }
    );

    if(result['result'] != null) { 
      final user = UserModel.fromJson(result['result']); 

      return AuthResult.success(user);
    } else { 
      
      return AuthResult.error(authError.authErrorsString(result['error']));
    
    }
  }

}