import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_flutter_app/data/app_exceptions.dart';
import 'package:product_flutter_app/models/postmodel/login/login_request.dart';
import 'package:product_flutter_app/repository/post/login_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var loadingLogin = false.obs;
  var loadingRegister = false.obs;
  final _loginRepository = LoginRepository();
  final ImagePicker _imagePicker = ImagePicker();
  Rxn<File?> selectedImageFile = Rxn<File?>();
  File? imageFile ;

  Future<void> login() async {
    if (usernameController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Username");
      return;
    }

    if (passwordController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Password");
      return;
    }

    loadingLogin(true);

    try {
      var response = await _loginRepository.login(
        phoneNumber: usernameController.value.text,
        password: passwordController.value.text,
      );
      Get.offAllNamed(RouteName.postSplash);
      _loginRepository.saveUserLocal(response);
    } on UnAuthorization {
      showCustomToast(message: "Username or Password Invalid!");
    }
    // catch (e) {
    //   showCustomToast(message: e.toString());
    // }
    finally {
      loadingLogin(false);
    }
  }

  // Function to select an image from the gallery and set it to `selectedImageFile`
  Future<void> chooseImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImageFile.value = File(pickedFile.path); // Update reactive variable
    } else {
      showCustomToast(message: "No image selected");
    }
  }

  // Function to upload the image to the server
  Future<void> uploadImage(BuildContext context) async {
    if (selectedImageFile == null) {
      showCustomToast(message: "Please select an image first!");
      return;
    }

    final url = Uri.parse("https://your-server-url.com/upload"); // Replace with your API endpoint
    final request = http.MultipartRequest('POST', url);

    request.files.add(await http.MultipartFile.fromPath(
      'image', // Parameter name expected by the API
      selectedImageFile.value!.path,
    ));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print("Image uploaded successfully");
        showCustomToast(message: "Image uploaded successfully");
      } else {
        print("Image upload failed");
        showCustomToast(message: "Image upload failed");
      }
    } catch (e) {
      print("Error uploading image: $e");
      showCustomToast(message: "Error uploading image: $e");
    }
  }

  // Register function to upload the selected image
  Future<void> register() async {



    if (firstNameController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your First Name");
      return;
    }

    if (lastNameController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Last Name");
      return;
    }

    if (usernameController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Username");
      return;
    }

    if (emailController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Email");
      return;
    }

    if (phoneController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Phone");
      return;
    }

    if (passwordController.value.text != confirmPasswordController.value.text) {
      showCustomToast(message: "Password does not match");
      return;
    }

    try {
      var response = await _loginRepository.register(
        phoneNumber: phoneController.value.text,
        password: passwordController.value.text,
        lastName: lastNameController.value.text,
        firstName: firstNameController.value.text,
        email: emailController.value.text,
        username: usernameController.value.text,
        confirmPassword: confirmPasswordController.value.text,
      );
      if(response.code == "200") {
        showCustomToast(message: response.message!);
        Get.offAllNamed(RouteName.postLogin);
      }else if(response.code == "400"){
        print("CODE 400");
        showCustomToast(message: response.message!);
      }
    } on UnAuthorization {
      showCustomToast(message: "Username or Password Invalid!");
    }
    // catch (e) {
    //   showCustomToast(message: e.toString());
    // }
    finally {
      loadingLogin(false);
    }

  }


}
