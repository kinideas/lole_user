import 'package:flutter/material.dart';
import 'package:lole/constants/colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon displayIcon;
  final String inputType;
  const CustomFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.displayIcon,
    this.inputType = "text",
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType == "email"
          ? TextInputType.emailAddress
          : inputType == "number"
              ? TextInputType.number
              : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: displayIcon,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: loleSecondaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      ),
    );
  }
}
