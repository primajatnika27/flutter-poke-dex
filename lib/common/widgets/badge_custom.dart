import 'package:flutter/material.dart';

class BadgeCustom extends StatelessWidget {
  final String type;
  final String size;
  const BadgeCustom({super.key, required this.type, this.size = 'small'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size == 'small' ? 8 : 12,
        vertical: size == 'small' ? 4 : 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular( size == 'small' ? 12 : 30),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
