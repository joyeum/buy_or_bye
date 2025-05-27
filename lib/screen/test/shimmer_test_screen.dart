import 'package:flutter/material.dart';
import '../../component/common/loading/loading_skeleton.dart';

class ShimmerTestScreen extends StatelessWidget {
  const ShimmerTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const LoadingSkeleton(),
    );
  }
} 