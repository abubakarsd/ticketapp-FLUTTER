// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ActionContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final image;
  final color;

  ActionContainer(
      {Key? key, this.onTap, required this.image, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 21,
        width: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.asset(
          image,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
