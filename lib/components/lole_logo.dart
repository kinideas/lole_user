import 'package:flutter/material.dart';

class LoleLogo extends StatelessWidget {
  const LoleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          110,
        ),
      ),
      child: Image.asset("assets/icons/Lole.png"),
    );
  }
}
