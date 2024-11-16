import 'package:flutter/material.dart';

class CustomSearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  CustomSearchBarWidget({
    Key? key,
    this.onChanged,
    this.onClear,
  })  : searchController = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 45, // Fixed height for consistency
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Search here...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          if (searchController.text.isNotEmpty) // Show clear button dynamically
            IconButton(
              onPressed: () {
                searchController.clear();
                if (onClear != null) {
                  onClear!();
                }
              },
              icon: Icon(Icons.close, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
