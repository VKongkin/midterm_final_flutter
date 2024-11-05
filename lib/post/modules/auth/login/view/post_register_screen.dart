import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/auth/login/controller/login_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class PostRegisterScreen extends StatefulWidget {
  PostRegisterScreen({super.key});

  @override
  State<PostRegisterScreen> createState() => _PostRegisterScreenState();
}

class _PostRegisterScreenState extends State<PostRegisterScreen> {
  LoginController loginController = Get.put(LoginController());

  bool _isPasswordVisible = false;
  bool _isVerifyPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0, // Remove shadow for a clean look
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back, // Custom back arrow icon
              color: Colors.black, // Black color for the arrow
            ),
            onPressed: () {
              // Add your back button action here
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Center the title text
            children: [
              Text(
                'Already have account?', // The first part of the text in black
                style: TextStyle(
                  color: Colors.black, // Black text color
                  fontSize: 16, // Adjust font size to match your design
                  fontWeight: FontWeight.w400, // Normal font weight
                ),
              ),
              SizedBox(width: 4), // Space between the two text parts
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(RouteName.postLogin);
                },
                child: Text(
                  'Login here', // The second part of the text in green
                  style: TextStyle(
                    color: Colors.blue, // Green text color
                    fontSize: 16, // Adjust font size to match your design
                    fontWeight: FontWeight.w400, // Normal font weight
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true, // Centers the title within the AppBar
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Register Account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),

                // Display the selected image or a placeholder
                // GestureDetector(
                //   onTap: () => loginController.chooseImage(),
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
                // SizedBox(
                //   height: 20,
                // ),
                //Username
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
                //Password
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
                SizedBox(height: 30),
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isVerifyPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey, // Icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isVerifyPasswordVisible = !_isVerifyPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Login button
                ElevatedButton(
                    onPressed: () {
                      // Handle login functionality here
                      loginController.register();
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
                        'Register',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      );
                    })),
                SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}