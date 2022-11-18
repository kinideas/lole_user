import 'package:flutter/material.dart';
import 'package:lole/screens/auth/otp_request_screen.dart';
import 'package:lole/screens/auth/otp_verification_screen.dart';
import 'package:lole/screens/auth/password_reset_screen.dart';
import 'package:lole/screens/auth/login_screen.dart';
import 'package:lole/screens/auth/register_screen.dart';
import 'package:lole/screens/homepage.dart';
import 'package:lole/screens/landing_screen.dart';
import 'package:lole/screens/tracking/tracking_screen.dart';

class AppRouter {
  final Map<String, WidgetBuilder> allRoutes = {
    LandingPage.routeName: (context) => const TrackingScreen(),
    LoginScreen.routeName: (context) => const LoginScreen(),
    RegisterScreen.routeName: (context) => const RegisterScreen(),
    PasswordResetScreen.routeName: (context) => const PasswordResetScreen(),
    OTPRequestScreen.routeName: (context) => const OTPRequestScreen(),

    OTPVerification.routeName: (context) =>
        const OTPVerification(fullName: "", phoneNumber: ""),

 
    HomePage.routeName:(context) => const HomePage()

  };
}
