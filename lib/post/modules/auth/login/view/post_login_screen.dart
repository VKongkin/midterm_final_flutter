import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/auth/login/controller/login_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostLoginScreen extends StatefulWidget {
   PostLoginScreen({super.key});

  @override
  State<PostLoginScreen> createState() => _PostLoginScreenState();
}

class _PostLoginScreenState extends State<PostLoginScreen> {
  LoginController loginController = Get.put(LoginController());

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16,top: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.grid_view_rounded, color: Colors.blue, size: 70),
                  Opacity(
                    opacity:
                    0.2, // Set the opacity (0.0 is fully transparent, 1.0 is fully opaque)
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor:
                        0.7, // Adjust this value to control how much of the right side is cut off
                        child: Icon(
                          Icons.grid_view_rounded,
                          color: Colors.blue,
                          size: 120,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Welcome to Online Shopping App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Login to get more discount products!",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),

              //Username
              Container(
                child: TextFormField(
                  controller: loginController.usernameController.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle_rounded,
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

              //Password
              Container(
                child:
                TextFormField(
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
                    suffixIcon:
                    IconButton(
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
              // Login button
              ElevatedButton(
                  onPressed: () {
                    // Handle login functionality here
                    loginController.login();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),  // Adjusted height (was 50 before)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),  // Rounded button
                    ),
                    backgroundColor: Colors.blue,  // Button color (Blue in this case)
                  ),
                  child:
                  Obx((){
                    if(loginController.loadingLogin.value){
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white,),
                      );
                    }
                    return Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    );
                  })

              ),
              SizedBox(height: 20),
              // Forgot password link
              GestureDetector(
                onTap: () {
                  // Handle forgot password navigation here
                  print("Forgot password clicked");
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue, // Link color
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'To get all of these promotion please ',  // Preceding text in English for demo
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'register now!',  // Text to act as a clickable link
                      style: TextStyle(
                        color: Colors.blue,  // Link color (same as in the image)
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle tap event (e.g., navigate to registration page)
                          Get.toNamed(RouteName.postAppRegister);
                        },
                    ),
                    // TextSpan(
                    //   text: ' to continue.',  // Continuing text after the link
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        )
    );

  }
}
