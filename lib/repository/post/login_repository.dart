import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/models/postmodel/login/login_request.dart';
import 'package:product_flutter_app/models/postmodel/login/login_response.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class LoginRepository{
  final _api = NetworkApiService();

  Future<LoginResponse> login({String? phoneNumber, String? password}) async {
    var loginResponse = new LoginResponse();
    var requestBody = LoginRequest(phoneNumber: phoneNumber, password: password);
    var response = await _api.loginApi(ApiUrl.postAppLoginPath, requestBody.toJson());
    loginResponse = LoginResponse.fromJson(response);
    return loginResponse;
  }

  Future<void> saveUserLocal(LoginResponse data) async {
    var storage = GetStorage();
    storage.write("USER_KEY", data.toJson());
  }

  Future<LoginResponse> getUserLocal() async {
    print("TRYING GET LOCAL USER");
    LoginResponse response = LoginResponse();
    var storage = GetStorage();
    var user = storage.read("USER_KEY");
    if(user != null){
      response = LoginResponse.fromJson(user);
    }else{
      print("RETURN WITHOUT USER");
    }
    return response;
  }
}