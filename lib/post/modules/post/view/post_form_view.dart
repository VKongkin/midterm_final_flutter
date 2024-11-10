import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostFormView extends StatefulWidget {
  const PostFormView({super.key});

  @override
  _PostFormViewState createState() => _PostFormViewState();
}

class _PostFormViewState extends State<PostFormView> {
  bool _isExpanded = false;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Listen to view insets changes (keyboard open/close)
      _checkKeyboardVisibility();
    });
  }

  void _checkKeyboardVisibility() {
    if (MediaQuery.of(context).viewInsets.bottom > 0.0) {
      // Keyboard is open, collapse the options menu
      if (_isExpanded) {
        setState(() {
          _isExpanded = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Get.offAllNamed(RouteName.postManagePath);
          },
        ),
        title: Text(
          "Create post",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(RouteName.postManagePath);
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // User Info Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: CachedNetworkImageProvider(
                            "${ApiUrl.postGetImagePath}1731171549276.jpeg",
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "KongKin Voeun",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildDropdownButton("Public"),
                                  SizedBox(width: 8),
                                  _buildDropdownButton("Category"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.white24),

                  // Text Input Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  ),
                  Divider(color: Colors.white24),

                  // Display Selected Image
                  if (_selectedImage != null)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          Image.file(
                            _selectedImage!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.black54,
                                child: Icon(Icons.close, color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Divider(color: Colors.white24),
                ],
              ),
            ),
            // Options Menu Section aligned to the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  // If dragging downwards, collapse the menu
                  if (details.primaryDelta! > 0 && _isExpanded) {
                    setState(() {
                      _isExpanded = false;
                    });
                  }
                  // If dragging upwards, expand the menu
                  else if (details.primaryDelta! < 0 && !_isExpanded) {
                    setState(() {
                      _isExpanded = true;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _isExpanded ? 300 : 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle bar
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: EdgeInsets.only(top: 8, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      if (!_isExpanded)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: Icon(Icons.photo, color: Colors.green),
                              ),
                              Icon(Icons.person_add, color: Colors.blue),
                              Icon(Icons.emoji_emotions, color: Colors.yellow),
                              Icon(Icons.location_on, color: Colors.red),
                              Icon(Icons.live_tv, color: Colors.pink),
                              Icon(Icons.text_format, color: Colors.teal),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Icon(Icons.expand_more, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      if (_isExpanded)
                        Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              _buildOptionItem(Icons.photo, "Photo/video", Colors.green, _pickImage),
                              _buildOptionItem(Icons.person_add, "Tag people", Colors.blue),
                              _buildOptionItem(Icons.emoji_emotions, "Feeling/activity", Colors.yellow),
                              _buildOptionItem(Icons.location_on, "Check in", Colors.red),
                              _buildOptionItem(Icons.live_tv, "Live video", Colors.pink),
                              _buildOptionItem(Icons.text_format, "Background color", Colors.teal),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown Button Builder
  Widget _buildDropdownButton(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
          Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  // Option Item Builder with tap action
  Widget _buildOptionItem(IconData icon, String text, Color color, [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: Colors.grey)),
      onTap: onTap,
    );
  }
}
