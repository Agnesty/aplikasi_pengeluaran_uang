// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class IconBar extends StatelessWidget {
  final IconData iconData;
  final Color color;
  const IconBar({
    Key? key,
    required this.iconData,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color),
        child: Icon(iconData, size: 28, color: Colors.black,),
      ),
    );
  }
}
