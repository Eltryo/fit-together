import 'package:flutter/material.dart';

class ShimmerLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const ShimmerLoading({
    required this.isLoading,
    required this.child,
    super.key,
  });

  final _shimmerGradient = const LinearGradient(
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

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => _shimmerGradient.createShader(bounds),
      child: child,
    );
  }
}
