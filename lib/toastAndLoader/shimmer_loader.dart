import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final bool isLoading;
  final List<String>? data;
  final Widget Function() shimmerBuilder;
  final Widget Function(List<String> data) dataBuilder;

  ShimmerLoader({
    required this.isLoading,
    required this.data,
    required this.shimmerBuilder,
    required this.dataBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? shimmerBuilder()
        : data != null
        ? dataBuilder(data!)
        : Center(child: Text('No data available'));
  }
}
