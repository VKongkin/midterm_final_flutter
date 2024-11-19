import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/auth/login/controller/login_controller.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class UserProfileUpdateView extends StatefulWidget {
  UserProfileUpdateView({super.key});

  @override
  State<UserProfileUpdateView> createState() => _UserProfileUpdateViewState();
}

class _UserProfileUpdateViewState extends State<UserProfileUpdateView> {
  LoginController loginController = Get.put(LoginController());
  final RootController rootController = Get.find<RootController>();
  File? _selectedImage;
  bool _isChecked = false;
  bool _isPasswordVisible = false;
  bool _isVerifyPasswordVisible = false;
  final ImagePicker _picker = ImagePicker();
  String? imagePath;

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        loginController.selectedImage = _selectedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Wait for the data to load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        imagePath = loginController.userRequest.value.profile;
        print(
            "Image URL: ${ApiUrl.postGetImagePath}${loginController.userRequest.value.profile}");
        print("Image path $imagePath");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check user role and conditionally render the buttons
    String role = rootController.userRole.value;
    bool isUser = role.contains("ROLE_USER");
    bool isAdmin = role.contains("ROLE_ADMIN");

    return Scaffold(
        appBar: AppBar(
          elevation: 0, // Remove shadow for a clean look
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios, // Custom back arrow icon
              color: Colors.black, // Black color for the arrow
            ),
            onPressed: () {
              // Add your back button action here
              // Navigator.of(context).pop();
              Get.back();
            },
          ),
          title: loginController.userRequest.value.id != 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Update Profile", // Display "Update Profile" text
                      style: TextStyle(
                        color: Colors.black, // Adjust the color if needed
                        fontSize: 20, // Adjust font size
                        fontWeight: FontWeight.w400, // Normal font weight
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Align the row content to the end
                  children: [
                    Text(
                      'Already have an account?', // The first part of the text in black
                      style: TextStyle(
                        color: Colors.black, // Black text color
                        fontSize: 16, // Adjust font size to match your design
                        fontWeight: FontWeight.w400, // Normal font weight
                      ),
                    ),
                    SizedBox(width: 4), // Space between the two text parts
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(
                            RouteName.postLogin); // Navigate to login screen
                      },
                      child: Text(
                        'Login here', // The second part of the text in blue
                        style: TextStyle(
                          color: Colors.blue, // Blue text color
                          fontSize: 16, // Adjust font size to match your design
                          fontWeight: FontWeight.w400, // Normal font weight
                        ),
                      ),
                    ),
                  ],
                ),

          centerTitle: true, // Centers the title within the AppBar
        ),
        body: Obx(() {
          if (loginController.loadingRegister.value) {
            return Center(child: CircularProgressIndicator(),);
          }
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  loginController.userRequest.value.id != 0
                      ? SizedBox.shrink()
                      : Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Register Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Display the selected image or a placeholder
                  // GestureDetector(
                  //   onTap: () => _pickImage(),
                  //   child: Obx(() {
                  //     // Display the selected image or a default icon
                  //     if (loginController.selectedImageFile.value != null) {
                  //       return Image.file(
                  //         loginController.selectedImageFile.value!,
                  //         width: 100,
                  //         height: 100,
                  //         fit: BoxFit.cover,
                  //       );
                  //     } else {
                  //       return Icon(
                  //         Icons.image,
                  //         size: 100,
                  //         color: Colors.grey,
                  //       );
                  //     }
                  //   }),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  loginController.userRequest.value.id != 0
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Stack(
                        children: [
                          // Check if editing mode and display the existing image if available
                          loginController.userRequest.value.id != 0 &&
                                  _selectedImage == null
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${ApiUrl.postGetImagePath}${loginController.userRequest.value.profile}",
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                              : (_selectedImage != null
                                  ? ClipOval(
                                      child: Image.file(
                                        _selectedImage!,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        color: Colors.grey[
                                            300], // Placeholder background
                                      ),
                                    )), // Placeholder if no image is picked in create mode
                          // "Clear Image" Button
                          if (_selectedImage != null ||
                              (loginController.userRequest.value.id != 0 &&
                                  loginController.userRequest.value.profile !=
                                      null))
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImage = null;
                                    loginController.selectedImage = null;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.black54,
                                  child: Icon(Icons.close,
                                      color: Colors.white, size: 18),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ) : SizedBox.shrink(),
                  SizedBox(
                    height: 20,
                  ),
                  // Username
                  Container(
                    child: TextFormField(
                      controller: loginController.firstNameController.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(),
                        hintText: "First Name *",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "First Name *",
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .blue, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFormField(
                      controller: loginController.lastNameController.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Last Name *",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Last Name *",
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .blue, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFormField(
                      controller: loginController.usernameController.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.supervised_user_circle_rounded,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .blue, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFormField(
                      controller: loginController.emailController.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Email *",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Email *",
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .blue, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFormField(
                      controller: loginController.phoneController.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_rounded,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Phone Number *",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Phone Number *",
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .blue, // Border color when the field is focused
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Checkbox to toggle visibility of password fields and role dropdown
                  CheckboxListTile(
                    title: Text("Reset Password and Roles"),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(isAdmin)
                  // Password Field (only visible when _isChecked is true)
                  Visibility(
                    visible: _isChecked,
                    child: Column(
                      children: [
                        // Password Field
                        Container(
                          child: TextFormField(
                            obscureText: !_isPasswordVisible,
                            controller: loginController.passwordController.value,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                color: Colors.blue,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey, // Border color when the field is focused
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue, // Border color when the field is focused
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey, // Icon color
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Confirm Password Field
                        Container(
                          child: TextFormField(
                            obscureText: !_isVerifyPasswordVisible,
                            controller: loginController.confirmPasswordController.value,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                color: Colors.blue,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Confirm Password *",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelText: "Confirm Password *",
                              labelStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey, // Border color when the field is focused
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue, // Border color when the field is focused
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isVerifyPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey, // Icon color
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVerifyPasswordVisible =
                                    !_isVerifyPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  if(isAdmin)
                  // Role Dropdown (only visible when _isChecked is true)
                  Visibility(
                    visible: _isChecked,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: loginController.selectedRoles.value.isEmpty
                              ? null
                              : loginController.selectedRoles.value, // Fallback to null if empty
                          onChanged: (newValue) {
                            loginController.selectedRoles.value = newValue!;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.supervised_user_circle,
                              color: Colors.blue,
                            ),
                            border: OutlineInputBorder(),
                            labelText: "Select Role *",
                            labelStyle: TextStyle(color: Colors.blue),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "ADMIN",
                              child: Text("ADMIN"),
                            ),
                            DropdownMenuItem(
                              value: "USER",
                              child: Text("USER"),
                            ),
                          ],
                          hint: Text("Select Role"), // Add a hint when no value is selected
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Login button
                  ElevatedButton(
                      onPressed: () {
                        // Handle login functionality here
                        _isChecked != true
                            ? loginController.onUpdateProfile() : loginController.onManageUser();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity,
                            45), // Adjusted height (was 50 before)
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded button
                        ),
                        backgroundColor:
                            Colors.blue, // Button color (Blue in this case)
                      ),
                      child: Obx(() {
                        if (loginController.loadingLogin.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        return Text(
                          loginController.userRequest.value.id != 0
                              ? 'Update': 'Register',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        );
                      })),
                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        }));
  }
}
