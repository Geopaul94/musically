import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key});

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Color _baseColor = const Color.fromARGB(255, 180, 178, 178);
  Color _highlightColor = const Color.fromARGB(255, 194, 189, 189);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startColorAnimation();
  }

  void _startColorAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
    
        _baseColor = _baseColor == const Color.fromARGB(255, 151, 147, 147) ? const Color.fromARGB(255, 168, 165, 165) : const Color.fromARGB(255, 86, 83, 83);
        _highlightColor = _highlightColor == Colors.grey[100] ? Colors.grey[200]! : Colors.grey[100]!;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _baseColor,
      highlightColor: _highlightColor,
      child: ListView.builder(
        itemCount: 5, 
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            height: 200.0, 
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        },
      ),
    );
  }
}