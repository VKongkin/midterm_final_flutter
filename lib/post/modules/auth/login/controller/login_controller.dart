import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_flutter_app/data/app_exceptions.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/models/postmodel/base_post_request.dart';
import 'package:product_flutter_app/models/postmodel/login/login_request.dart';
import 'package:product_flutter_app/models/postmodel/response/user.dart';
import 'package:product_flutter_app/models/postmodel/response/user_res.dart';
import 'package:product_flutter_app/models/postmodel/user_update_req/User_request.dart';
import 'package:product_flutter_app/post/modules/auth/user_response.dart';
import 'package:product_flutter_app/repository/post/login_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var selectedRoles = "".obs;
  var userManageRole = "".obs;
  var userId = 0.obs;
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var userRequest = UserRes().obs;
  var userManageRequest = UserRequest().obs;
  var loadingLogin = false.obs;
  var loadingRegister = false.obs;
  RxString filenameUploaded = "".obs;
  File? selectedImage;
  final _loginRepository = LoginRepository();
  final ImagePicker _imagePicker = ImagePicker();
  Rxn<File?> selectedImageFile = Rxn<File?>();
  File? imageFile;
  var imagePathUrl = "".obs;
  var imageFilePath = "".obs;

  @override
  void onInit() async {
    super.onInit();
    getUserById();
  }

  initRole(){
    bool isUser = userManageRole.value.contains("ROLE_USER");
    bool isAdmin = userManageRole.value.contains("ROLE_ADMIN");
  }

  getUserById() async {
    try {
      loadingRegister(true);
      int id = int.parse(Get.parameters["id"] ?? "0");
      print("REGISTER USER ID: $id");
      var request = BasePostRequest();
      if (id != 0) {
        request.userId = id;
        userId.value = id;
        var response = await _loginRepository.getUserById(request);

        // Check response code and deserialize
        if (response.code == "200") {
          userRequest.value =
              UserRes.fromJson(response.data); // Deserialize JSON to User
          print("Deserialized User: ${userRequest.value.toJson()}");
          firstNameController.value.text = userRequest.value.firstName!;
          lastNameController.value.text = userRequest.value.lastName!;
          usernameController.value.text = userRequest.value.username!;
          emailController.value.text = userRequest.value.email!;
          phoneController.value.text = userRequest.value.phoneNumber!;
          imageFilePath.value = userRequest.value.profile!;
          filenameUploaded.value = userRequest.value.profile!;
          var roles = await userRequest.value.roles!; // Access roles list
          userManageRole.value = roles.map((role) => role['name'].toString()).join(", ");
          print("ROLE USER ${userManageRole}"); // Output: ['ROLE_ADMIN']
          if(userManageRole.value.contains("ROLE_ADMIN")){
            selectedRoles.value = "ADMIN";
          }else if(userManageRole.value.contains("ROLE_USER")){
            selectedRoles.value = "USER";
          }else if(userManageRole.value.contains("ROLE_USER") || userManageRole.value.contains("ROLE_ADMIN")){
            selectedRoles.value = "ADMIN";
          }else{
            selectedRoles.value = "USER";

          }
          print("USER IMAGE ${userRequest.value.profile}");
        } else {
          print("Error: ${response.message}");
        }
      }else{
        userRequest.value.id = id;
      }
    } catch (e) {
      print("Error fetching user: $e");
    } finally {
      loadingRegister(false);
    }
  }

  onUpdateProfile() async{
    if(selectedImage==null){
      filenameUploaded.value = imageFilePath.value;
      print(filenameUploaded);
    }
    try {
      if(selectedImage != null) {
        await uploadImage(selectedImage!);
      }else{
        if(userRequest.value.id != 0){
          filenameUploaded.value = imageFilePath.value;
          print(filenameUploaded);
        }else{
          filenameUploaded.value = "NON";
        }
      }
      userRequest.value.firstName = firstNameController.value.text;
      userRequest.value.lastName = lastNameController.value.text;
      userRequest.value.username = usernameController.value.text;
      userRequest.value.email = emailController.value.text;
      userRequest.value.phoneNumber = phoneController.value.text;
      userRequest.value.profile = filenameUploaded.value;

      var response = await _loginRepository.updateProfile(userRequest.value);
      if(response.code == "200"){
        Get.back(result: true);
        // showCustomToast(message: "${response.data}");
      }else{
        showCustomToast(message: response.data);
      }


      print("PRINT RES ${response.toString()}");
      print(userRequest.value.firstName);
    }finally{

    }
  }

  onManageUser() async{
    print("Manage click");
    if(selectedImage==null){
      filenameUploaded.value = imageFilePath.value;
      print(filenameUploaded);
    }
    try {
      if(selectedImage != null) {
        await uploadImage(selectedImage!);
      }else{
        if(userRequest.value.id != 0){
          filenameUploaded.value = imageFilePath.value;
          print(filenameUploaded);
        }else{
          filenameUploaded.value = "NON";
        }
      }
      userManageRequest.value.id = userId.value;
      userManageRequest.value.firstName = firstNameController.value.text;
      userManageRequest.value.lastName = lastNameController.value.text;
      userManageRequest.value.username = usernameController.value.text;
      userManageRequest.value.email = emailController.value.text;
      userManageRequest.value.phoneNumber = phoneController.value.text;
      userManageRequest.value.profile = filenameUploaded.value;
      userManageRequest.value.password = passwordController.value.text;
      userManageRequest.value.confirmPassword = confirmPasswordController.value.text;
      userManageRequest.value.role = selectedRoles.value;
      userManageRequest.value.status = "ACT";

      // print(userManageRequest.value.role);
      var response = await _loginRepository.manageUserProfile(userManageRequest.value);
      if(response.code == "200"){
        Get.back(result: true);
        // showCustomToast(message: "${response.data}");
      }else{
        showCustomToast(message: response.data);
      }


      print("PRINT RES ${response.toString()}");
      print(userRequest.value.firstName);
    }finally{

    }
  }

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
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImageFile.value =
          File(pickedFile.path); // Update reactive variable
    } else {
      showCustomToast(message: "No image selected");
    }
  }

  // Function to upload the image to the server
  // Future<void> uploadImage(BuildContext context) async {
  //   if (selectedImageFile == null) {
  //     showCustomToast(message: "Please select an image first!");
  //     return;
  //   }
  //
  //   final url = Uri.parse(
  //       "https://your-server-url.com/upload"); // Replace with your API endpoint
  //   final request = http.MultipartRequest('POST', url);
  //
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'image', // Parameter name expected by the API
  //     selectedImageFile.value!.path,
  //   ));
  //
  //   try {
  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       print("Image uploaded successfully");
  //       showCustomToast(message: "Image uploaded successfully");
  //     } else {
  //       print("Image upload failed");
  //       showCustomToast(message: "Image upload failed");
  //     }
  //   } catch (e) {
  //     print("Error uploading image: $e");
  //     showCustomToast(message: "Error uploading image: $e");
  //   }
  // }

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
      if (response.code == "200") {
        showCustomToast(message: response.message!);
        Get.offAllNamed(RouteName.postLogin);
      } else if (response.code == "400") {
        print("CODE 400");
        showCustomToast(message: response.message!);
      }
    } on UnAuthorization {
      showCustomToast(message: "Username or Password Invalid!");
    } catch (e) {
      showCustomToast(message: e.toString());
    } finally {
      loadingLogin(false);
    }
  }

  Future uploadImage(File imageFile) async {
    try {
      var response = await _loginRepository.uploadImage(imageFile);
      print(response.data['data']);
      filenameUploaded.value = response.data['data'];
      print(response.code);
      if(response.code == "200"){
        print("Print file ${filenameUploaded}");
        // await onCreatePost();
        // Get.offAllNamed(RouteName.postManagePath);
      }else{
        showCustomToast(message: response.message.toString());
      }
      // Handle success
      print("Image uploaded successfully1: ${response.data.data}");
    } catch (e) {
      // Handle errors
      print("Image upload failed: $e");
    }

  }
}
