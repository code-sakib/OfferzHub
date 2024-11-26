// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ScreenSize {
  double height;
  double width;
  ScreenSize({
    required this.height,
    required this.width,
  });
}

ScreenSize sizes(BuildContext context) {
  final sizes = MediaQuery.sizeOf(context);
  return ScreenSize(height: sizes.height, width: sizes.width);
}
