import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Center(
        child: SpinKitFadingCircle(
          color: Color(0xFF064D3B),
          size: 60.0,
        ),
      ),
    );
  }
}
