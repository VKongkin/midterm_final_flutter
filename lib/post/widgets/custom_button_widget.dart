import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  VoidCallback onTab;
  bool onLoading;
  String? title;
  int? borderRadius;
  CustomButtonWidget({
    super.key,
    required this.onTab,
    this.onLoading = false,
    this.title,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
          onPressed: onTab,
          style: ElevatedButton.styleFrom(
            minimumSize:
                Size(double.infinity, 45), // Adjusted height (was 50 before)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  (borderRadius ?? 30).toDouble()), // Rounded button
            ),
            backgroundColor: Colors.blue, // Button color (Blue in this case)
          ),
          child: onLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  title ?? "",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
    );
  }
}
