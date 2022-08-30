import 'package:greengrocer_course/src/constants/endpoints.dart';
import 'package:greengrocer_course/src/services/http_manager.dart';

class AuthRepository {

  final HttpManager _httpManager = HttpManager();

  Future signIn({
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
      print('Signin functiou');
      print(result['result']);
    } else {
      print('Signin não functiou');
    }
  }

}