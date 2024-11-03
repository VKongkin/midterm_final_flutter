import 'package:flutter/material.dart';
import 'package:product_flutter_app/modules/home/widget/home_product_all_widget.dart';

class ProductSeeAllScreen extends StatefulWidget {
  const ProductSeeAllScreen({super.key});

  @override
  State<ProductSeeAllScreen> createState() => _ProductSeeAllScreenState();
}

class _ProductSeeAllScreenState extends State<ProductSeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8FB9FF),
      body: HomeProductAllWidget(),
    );
  }
}
