import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerView({double width = 80, double height = 14}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}
