import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/data/app_exceptions.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/remote/base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:product_flutter_app/models/postmodel/login/login_response.dart';
import 'package:product_flutter_app/models/postmodel/login/refresh_token_request.dart';
import 'package:product_flutter_app/models/postmodel/login/user.dart';
import 'package:product_flutter_app/repository/post/login_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class NetworkApiService implements BaseApiService {
  @override
  Future getApi(String url) async {
    if (kDebugMode) {
      print("GET REQUEST URL $url\n");
    }
    dynamic responseJson;
    try {
      var response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
        case 400:
          throw UnAuthorization();
        case 500:
          throw InternalServerException();
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    if (kDebugMode) {
      print("GET RESPONSE BODY $responseJson\n");
    }
    return responseJson;
  }

  @override
  Future postApi(String url, requestBody) async {
    if (kDebugMode) {
      print("GET REQUEST URL $url\n");
    }
    dynamic responseJson;
    try {
      var storage = GetStorage();
      var user = LoginResponse.fromJson(storage.read("USER_KEY"));
      var token = "";
      if (user.refreshToken != null) {
        token = user.accessToken ?? "";
      }
      var response = await http
          .post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${token}'
              },
              body: jsonEncode(requestBody))
          .timeout(const Duration(seconds: 60));
      print("STATUS CODE POST: ${response.statusCode}");
      print("RESPONSE POST: ${response.body}");
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          print("POST API CODE 200");
          break;
        case 401:
          print("POST API CODE 400");
          if (await refreshTokenApi() == true) {
            print("ON RETRY POST");
            responseJson = await refresh(url,requestBody);
            break;
          } else {
            Get.offAllNamed(RouteName.postSplash);
          }
        case 500:
          throw InternalServerException();
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    if (kDebugMode) {
      print("GET RESPONSE POST API BODY $responseJson\n");
    }
    return responseJson;
  }

  @override
  Future postApiUploadImage(String url, File imageFile) async {
    if (kDebugMode) {
      print("POST REQUEST URL: $url\n");
    }
    dynamic responseJson;

    try {
      // Create a Multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add headers
      request.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ2a29uZ2tpbiIsImlhdCI6MTczMDY2MDQ5MywiZXhwIjoxNzMwNjYwNzkzfQ.yTQNh_OHhTHnhUbNPUxIuYwdiJE1afw96yVsUYbmOUvqVhYpwbTo7Aajk8YOoQyuYNt1f0T74BpzrRqRHx4Vtg';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Attach the image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // The name parameter here should match the expected key on the server
          imageFile.path,
        ),
      );

      // Send the request and get the response
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      print("STATUS CODE POST: ${response.statusCode}");
      print("RESPONSE POST: $responseString");

      // Parse the response
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(responseString);
          print("POST API CODE 200: Success");
          break;

        case 401:
          print("POST API CODE 401: Unauthorized");
          bool refreshed = await _handleTokenRefresh(url, imageFile);
          if (refreshed) {
            return await postApiUploadImage(url, imageFile); // Retry after refresh
          } else {
            Get.offAllNamed(RouteName.postSplash); // Navigate to splash screen
             print("Unauthorized: Token refresh failed");
          }

        case 500:
          throw InternalServerException("Internal Server Error");

        default:
          throw HttpException("Unexpected status code: ${response.statusCode}");
      }
    } on SocketException {
      throw NoInternetConnectionException("No Internet Connection");
    } on TimeoutException {
      throw RequestTimeOutException("Request Timed Out");
    } catch (e) {
      // Log any other unexpected exceptions for debugging
      print("Unexpected error: $e");
      rethrow; // Rethrow the exception for higher-level handling
    }

    if (kDebugMode) {
      print("RESPONSE POST API BODY: $responseJson\n");
    }

    return responseJson;
  }

// Helper function to handle token refresh and retry
  Future<bool> _handleTokenRefresh(String url, dynamic requestBody) async {
    try {
      bool tokenRefreshed = await refreshTokenApi();
      if (tokenRefreshed) {
        print("Token refreshed successfully, retrying POST request");
        return true;
      } else {
        print("Token refresh failed");
        return false;
      }
    } catch (e) {
      print("Error during token refresh: $e");
      return false;
    }
  }


  @override
  Future loginApi(String url, requestBody) async {
    if (kDebugMode) {
      print("GET REQUEST URL $url\n");
    }
    dynamic responseJson;
    try {
      var response = await http
          .post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(requestBody))
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
          case 400:
          responseJson = jsonDecode(response.body);
          break;
        case 401:
          throw UnAuthorization();
        case 500:
          throw InternalServerException();
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    if (kDebugMode) {
      print("GET RESPONSE LOGIN API BODY $responseJson\n");
    }
    return responseJson;
  }

  Future<bool> refreshTokenApi() async {
    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var storage = GetStorage();

      // Retrieve and parse the stored `LoginResponse`
      var savedLoginResponse = LoginResponse.fromJson(storage.read("USER_KEY"));
      print("USER accessToken: ${savedLoginResponse.accessToken}");

      // Prepare the refresh token request
      var refreshTokenRequest = RefreshTokenRequest(refreshToken: savedLoginResponse.refreshToken);

      // Send the HTTP POST request to refresh the token
      var response = await http
          .post(
        Uri.parse(ApiUrl.postAppRefreshTokenPath),
        headers: headers,
        body: jsonEncode(refreshTokenRequest),
      )
          .timeout(const Duration(seconds: 60));

      print("Response body: ${response.body}");

      switch (response.statusCode) {
        case 200:
          print("CODE 200: Success");

          // Decode the JSON response
          var responseJson = jsonDecode(response.body);

          // Deserialize the response JSON into `LoginResponse`
          var updatedLoginResponse = LoginResponse.fromJson(responseJson);

          // Store the updated `LoginResponse` in storage
          storage.write("USER_KEY", updatedLoginResponse.toJson());

          print("New access token stored, returning true");
          return true; // Token refresh successful

        case 401:
          print("Unauthorized (401), returning false");
          storage.remove("USER_KEY");
          Get.offAllNamed(RouteName.postSplash);
          return false; // Unauthorized

        case 500:
          throw InternalServerException(); // Server error

        default:
          print("Unexpected status code: ${response.statusCode}");
          return false; // Handle unexpected status codes
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
  }

  Future refresh(String url, requestBody) async {
    print("REFRESH TOKEN");
    dynamic responseJson;
    try {
      var storage = GetStorage();
      var user = LoginResponse.fromJson(storage.read("USER_KEY"));
      var token = "";
      if (user.refreshToken != null) {
        token = user.accessToken ?? "";
      }
      var response = await http
          .post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${token}'
          },
          body: jsonEncode(requestBody))
          .timeout(const Duration(seconds: 60));
      print("STATUS CODE REFRESH: ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          print("REFRESH API CODE 200");
          // break;
        case 401:
          print("REFRESH API CODE 400");
          if (await refreshTokenApi() == true) {
            print("ON RETRY REFRESH");
          } else {
            Get.offAllNamed(RouteName.postSplash);
          }
        case 500:
          throw InternalServerException();
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeOutException();
    }
    return responseJson;
  }

}
