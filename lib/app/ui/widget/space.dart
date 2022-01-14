import 'package:flutter/material.dart';
class Height extends StatelessWidget {
  const Height({Key? key, required this.space}) : super(key: key);
  final double space;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
    );
  }
}
