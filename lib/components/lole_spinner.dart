import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lole/constants/colors.dart';

class LoleSpinner extends StatelessWidget {
  const LoleSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitPulse(
      color: loleSecondaryColor,
    );
  }
}
