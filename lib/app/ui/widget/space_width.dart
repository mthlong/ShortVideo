import 'package:flutter/material.dart';
class Width extends StatelessWidget {
  const Width({Key? key, required this.space}) : super(key: key);
  final double space;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: space,
    );
  }
}