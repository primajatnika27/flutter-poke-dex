import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowInfoWidget extends StatelessWidget {
  final String label;
  final String value;
  const RowInfoWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
