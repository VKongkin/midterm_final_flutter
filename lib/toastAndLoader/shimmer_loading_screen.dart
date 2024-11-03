import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.flex,
    required this.widthFactor,
  });

  final int flex;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white.withOpacity(0.5),
          ),
        ),
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

class ShimmerView extends StatefulWidget {
  const ShimmerView({super.key});

  @override
  _ShimmerViewState createState() => _ShimmerViewState();
}

class _ShimmerViewState extends State<ShimmerView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: const [
                    ShimmerBox(flex: 6, widthFactor: 1),
                    // ShimmerBox(flex: 6, widthFactor: 0.9),
                  ],
                ),
              ),
              Container(
                height: 230,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: const [
                    ShimmerBox(flex: 6, widthFactor: 0.9),
                    ShimmerBox(flex: 6, widthFactor: 0.9),
                  ],
                ),
              ),
              Container(
                height: 230,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: const [
                    ShimmerBox(flex: 6, widthFactor: 0.9),
                    ShimmerBox(flex: 6, widthFactor: 0.9),
                  ],
                ),
              ),
            ],
          ),
          blendMode: BlendMode.srcATop,
        );
      },
    );
  }
}

class ShimmerLoadingScreen extends StatelessWidget {
  const ShimmerLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Loading Effect'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: ShimmerView(),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ShimmerLoadingScreen(),
  ));
}
