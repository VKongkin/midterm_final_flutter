import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/category/view_model/post_category_view_model.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_form_view_model.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostFormView extends StatefulWidget {
  PostFormView({super.key});

  @override
  _PostFormViewState createState() => _PostFormViewState();
}

class _PostFormViewState extends State<PostFormView> {
  final PostFormViewModel viewModel = Get.put(PostFormViewModel());
  final PostCategoryViewModel categoryViewModel =
      Get.put(PostCategoryViewModel());

  bool _isExpanded = false;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String _selectedStatus = "Public"; // Default value for visibility dropdown
  String _selectedCategory = "Category"; // Default value for category
  var fileName = "";

  @override
  void initState() {
    super.initState();

    // Add a delay to allow time for imageFilePath to be set in viewModel
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {}); // Rebuild the widget after the delay
    });
  }

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        viewModel.selectedImage = _selectedImage;
      });
    }
  }

  Widget _buildImageDisplay(String? imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: imageUrl != null
          // If imageUrl is set, display the image from the network
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )
          : viewModel.selectedImage != null
              // If a new image has been picked, display it
              ? Image.file(
                  viewModel.selectedImage!,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.image,
                  size: 50, color: Colors.grey), // Placeholder icon
    );
  }

  void _checkKeyboardVisibility() {
    if (MediaQuery.of(context).viewInsets.bottom > 0.0) {
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
            Get.back();
          },
        ),
        title: Text(
          viewModel.postRequest.value.id != 0 ? "Update Post" : "Create Post",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              viewModel.onCreateOrUpdatePost(viewModel.postRequest.value.id ??
                  0); // Call create post method
              // Get.offAllNamed(RouteName.postManagePath);
            },
            child: Text(
              viewModel.postRequest.value.id != 0 ? "Update" : "Create",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     viewModel.uploadImage(_selectedImage!); // Call create post method
          //     // Get.offAllNamed(RouteName.postManagePath);
          //   },
          //   child: Text(
          //     "Upload",
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[500],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.public,
                                            color: Colors.blue[50],
                                            size: 12,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            "Public",
                                            style: TextStyle(
                                              color: Colors.blue[50],
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          // Icon(
                                          //   Icons.arrow_drop_down,
                                          //   color: Colors.blue[200],
                                          //   size: 16,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 210),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white24),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: viewModel.postDescriptionController.value,
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          // Check if editing mode and display the existing image if available
                          viewModel.postRequest.value.id != 0 &&
                                  _selectedImage == null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      "${ApiUrl.postGetImagePath}${viewModel.imageFilePath}",
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      SizedBox.shrink(),
                                )
                              : (_selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Container()), // Placeholder if no image is picked in create mode
                          // "Clear Image" Button
                          if (_selectedImage != null ||
                              (viewModel.postRequest.value.id != 0 &&
                                  viewModel.postRequest.value.image != null))
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImage = null;
                                    viewModel.selectedImage = null;
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
                    Divider(color: Colors.white24),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _isExpanded ? 300 : 60,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    onVerticalDragUpdate: (details) {
                      if (details.primaryDelta! < -7) {
                        setState(() {
                          _isExpanded = true;
                        });
                      } else if (details.primaryDelta! > 7) {
                        setState(() {
                          _isExpanded = false;
                        });
                      }
                    },
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  if (!_isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
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
                        ],
                      ),
                    ),
                  if (_isExpanded)
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Obx(() => _buildOptionItem(
                                Icons.category,
                                viewModel.postRequest.value.id != 0
                                    ? viewModel.selectedCategory.value?.name ??
                                        "Select Category"
                                    : _selectedCategory,
                                Colors.blue,
                                _showCategoryPicker,
                              )),
                          _buildOptionItem(Icons.photo, "Photo/video",
                              Colors.green, _pickImage),
                          _buildOptionItem(
                              Icons.person_add, "Tag people", Colors.blue),
                          _buildOptionItem(Icons.emoji_emotions,
                              "Feeling/activity", Colors.yellow),
                          _buildOptionItem(
                              Icons.location_on, "Check in", Colors.red),
                          _buildOptionItem(
                              Icons.live_tv, "Live video", Colors.pink),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return ListView.builder(
            itemCount: categoryViewModel.categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryViewModel.categoryList[index];
              return ListTile(
                title: Text(category.name ?? ""),
                onTap: () {
                  viewModel.selectedCategory.value =
                      category; // Set the selected category in viewModel
                  Navigator.pop(context);
                },
              );
            },
          );
        });
      },
    );
  }

  Widget _buildDropdownButtonStatus(String title, List<String> options,
      String selectedValue, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 80,
        child: DropdownButton<String>(
          value: options.contains(selectedValue) ? selectedValue : null,
          hint:
              Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
          dropdownColor: Colors.blue,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
          underline: SizedBox(),
          onChanged: onChanged,
          isDense: true,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String text, Color color,
      [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: Colors.grey)),
      onTap: onTap,
    );
  }
}
