import 'package:flutter/material.dart';
import 'package:lole/constants/colors.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String label;

  const CustomPrimaryButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 75),
        decoration: BoxDecoration(
          color: loleSecondaryColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 0,
            color: loleSecondaryColor,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
