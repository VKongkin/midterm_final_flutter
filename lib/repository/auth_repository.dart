import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/modules/auth/login_request.dart';
import 'package:product_flutter_app/modules/auth/login_response.dart';

class AuthRepository {
  final _networkApiService = NetworkApiService();


  Future<LoginResponse> login(LoginRequest req) async {
    var response = await _networkApiService.postApi(ApiUrl.loginPath, req.toJson());
    LoginResponse loginResponse = LoginResponse.fromJson(response);


    saveUserLocal(loginResponse);

    // Cache the user image after successful login
    await cacheUserImage(loginResponse.image);

    return loginResponse;
  }

  Future<void> saveUserLocal(LoginResponse data) async {
    var storage = GetStorage();
    storage.write("USER_KEY", data.toJson());
  }

  Future<LoginResponse> getUserLocal() async {
    var storage = GetStorage();
    return LoginResponse.fromJson(storage.read("USER_KEY"));
  }

  // New method to cache user image
  Future<void> cacheUserImage(String? imageUrl) async {
    if (imageUrl != null) {
      await _deleteCachedImage();
      await _cacheImageLocally(imageUrl);
    }
  }

  // Function to download and save the image locally
  Future<void> _cacheImageLocally(String imageUrl) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/profile_image.jpg';  // File name and path

      // Check if the image is already cached
      if (await File(filePath).exists()) {
        print("Image already cached at: $filePath");
        return;
      }

      // Download the image using Dio
      Dio dio = Dio();
      await dio.download(imageUrl, filePath);
      print("Image saved to: $filePath");
      print("Image URL: $imageUrl");
    } catch (e) {
      print("Error caching image: $e");
    }
  }

  // Function to get the cached image path if exists
  Future<String?> getCachedImagePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/profile_image.jpg';

    // Check if file exists
    if (await File(filePath).exists()) {
      print("Image retrieved from: $filePath");
      return filePath; // Return the cached file path
    } else {
      return null; // Image not cached yet
    }
  }

  Future<void> _deleteCachedImage() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/profile_image.jpg';

      File file = File(filePath);
      if (await file.exists()) {
        await file.delete();  // Delete the file if it exists
        print("Cached image deleted: $filePath");
      } else {
        print("No cached image found to delete.");
      }
    } catch (e) {
      print("Error deleting cached image: $e");
    }
  }
}
