import 'package:flutter/material.dart';
import 'package:product_flutter_app/toastAndLoader/shimmer_loading_screen.dart'; // Assuming your shimmer code is here

class ProductCardListLoadingShimmer extends StatefulWidget {
  final int? flex;
  final double? widthFactor;
  final double? height;


  ProductCardListLoadingShimmer({
    super.key,
    this.flex,
    this.widthFactor,
    this.height,
  });

  @override
  State<ProductCardListLoadingShimmer> createState() => _ProductCardListLoadingShimmerState();
}

class _ProductCardListLoadingShimmerState extends State<ProductCardListLoadingShimmer> with SingleTickerProviderStateMixin {
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
        top: 10
      ),
      child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,

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
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Use the dynamic flex and widthFactor values here
                      Container(
                        height: 200,
                        // margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            ShimmerBox(flex: flexValue, widthFactor: widthFactorValue),
                            // ShimmerBox(flex: 6, widthFactor: 0.9),
                          ],
                        ),
                      ),
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
