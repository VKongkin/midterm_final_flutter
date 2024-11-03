import 'package:flutter/material.dart';
import 'package:product_flutter_app/toastAndLoader/shimmer_placeholder.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          ShimmerPlaceholder(height: 80,width: 80,),
          SizedBox(width: 10,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerPlaceholder(),
              SizedBox(height: 10,),
              ShimmerPlaceholder(),
              SizedBox(height: 10),
              ShimmerPlaceholder(width: 50,),
              SizedBox(height:  10,)
            ],
          ))
        ],
      ),
    );
  }
}
