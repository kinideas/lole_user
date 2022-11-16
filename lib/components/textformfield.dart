import 'package:flutter/material.dart';
class TextfieldHomepage extends StatelessWidget {
  const TextfieldHomepage({
    Key? key,
    required this.nameController, required this.hintext, required this.type,
  }) : super(key: key);

  final TextEditingController nameController;
  final hintext;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        
        
        controller: nameController,
        keyboardType: type,
        decoration: InputDecoration(
         
          hintText: hintext,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
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
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    );
  }
}