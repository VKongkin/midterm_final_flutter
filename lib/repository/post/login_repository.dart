import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/models/postmodel/login/login_request.dart';
import 'package:product_flutter_app/models/postmodel/login/login_response.dart';
import 'package:product_flutter_app/models/postmodel/post_base_response.dart';
import 'package:product_flutter_app/models/postmodel/post_upload_response.dart';
import 'package:product_flutter_app/models/postmodel/register/register_request.dart';
import 'package:product_flutter_app/models/postmodel/register/register_response.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class LoginRepository {
  final _api = NetworkApiService();

  Future<LoginResponse> login({String? phoneNumber, String? password}) async {
    var loginResponse = new LoginResponse();
    var requestBody =
        LoginRequest(phoneNumber: phoneNumber, password: password);
    var response =
        await _api.loginApi(ApiUrl.postAppLoginPath, requestBody.toJson());
    loginResponse = LoginResponse.fromJson(response);
    return loginResponse;
  }

  Future<RegisterResponse> register({
    String? phoneNumber,
    String? password,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? confirmPassword,
  }) async {
    var registerResponse = new RegisterResponse();
    var requestBody = RegisterRequest(
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );
    var response =
        await _api.loginApi(ApiUrl.postAppRegisterPath, requestBody.toJson());
    registerResponse = RegisterResponse.fromJson(response);
    // showCustomToast(message: registerResponse.message!);
    return registerResponse;
  }

  Future<PostUploadResponse> uploadImage(File imageFile) async {
    var uploadImageResponse = new PostUploadResponse();

    // Define the API endpoint
    final url = Uri.parse(ApiUrl.postUploadImagePath);

    // Create the multipart request
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'File', // Name parameter expected by your API
        imageFile.path,
      ),
    );

    // try {
    // Send the request
    var streamedResponse = await request.send();
    // var response = await http.Response.fromStream(streamedResponse);

    var response = await _api.postApiUploadImage(
        ApiUrl.postUploadImagePath, request.files as File);
    // Handle the response
    if (response.statusCode == 200) {
      // Parse JSON response into your custom response model
      uploadImageResponse = PostUploadResponse.fromJson(response.body);
    } else {
      throw Exception("Failed to upload image: ${response.statusCode}");
    }
    // } catch (e) {
    //   throw Exception("Error uploading image: $e");
    // }

    return uploadImageResponse;
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
    if (user != null) {
      response = LoginResponse.fromJson(user);
    } else {
      print("RETURN WITHOUT USER");
    }
    return response;
  }
}
