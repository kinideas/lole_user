import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lole/constants/colors.dart';

class LoleSpinner extends StatelessWidget {
  const LoleSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitPulse(
      color: loleSecondaryColor,
    );
  }
}
