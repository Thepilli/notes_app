import 'package:flutter/material.dart';

class HeightBox extends StatelessWidget {
  const HeightBox({
    super.key,
    required this.size,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
