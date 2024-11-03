import 'package:flutter/material.dart';
import 'package:product_flutter_app/toastAndLoader/shimmer_loading_screen.dart'; // Assuming your shimmer code is here

class HomeProductLoadingShimmer extends StatefulWidget {
  final int? flex;
  final double? widthFactor;
  final double? height;

  HomeProductLoadingShimmer({
    super.key,
    this.flex,
    this.widthFactor,
    this.height,
  });

  @override
  State<HomeProductLoadingShimmer> createState() => _HomeProductLoadingShimmerState();
}

class _HomeProductLoadingShimmerState extends State<HomeProductLoadingShimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16,
        bottom: 16,
      ),
      child: GridView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          // Use the nullable `flex` and `widthFactor`, but provide defaults if they are null.
          final int flexValue = widget.flex ?? 6; // Default to 6 if null
          final double widthFactorValue = widget.widthFactor ?? 1.0; // Default to 1.0 if null

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) {
                  return _shimmerGradient.createShader(
                    Rect.fromLTWH(
                      -bounds.width + (bounds.width * 2 * _controller.value),
                      0,
                      bounds.width,
                      bounds.height,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Column(
                    children: [
                      // Use the dynamic flex and widthFactor values here
                      ShimmerBox(flex: flexValue, widthFactor: widthFactorValue),
                    ],
                  ),
                ),
                blendMode: BlendMode.srcATop,
              );
            },
          );
        },
      ),
    );
  }
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
