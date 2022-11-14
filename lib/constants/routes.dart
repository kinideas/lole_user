import 'package:flutter/material.dart';
import 'package:lole/screens/auth/components/password_reset_screen.dart';
import 'package:lole/screens/auth/login_screen.dart';
import 'package:lole/screens/auth/register_screen.dart';

class AppRouter {
  final Map<String, WidgetBuilder> allRoutes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    RegisterScreen.routeName: (context) => const RegisterScreen(),
    PasswordResetScreen.routeName: (context) => const PasswordResetScreen()
  };
}
