import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lole/screens/auth/otp_verification_screen.dart';
import 'package:lole/screens/home_screen.dart';
import 'package:lole/services/api/AuthenticationService.dart';
import 'package:lole/services/api/UtilService.dart';

import '../../constants/functions.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isLoading = false;
  final AuthenticationService _authenticationService = AuthenticationService();
  final UtilService _utilService = UtilService();

  // Registration
  Future<String> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String phoneNumber = "",
  }) async {
    isLoading = true;
    notifyListeners();

    String result =
        await _authenticationService.registerUserWithEmailAndPassword(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
    );

    isLoading = false;
    notifyListeners();

    return result;
  }

  // Login
  Future<String> loginWithGoogle() async {
    isLoading = true;
    notifyListeners();

    String result = await _authenticationService.loginUserWithGoogle();

    isLoading = false;
    notifyListeners();

    return result;
  }

  Future<String> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    isLoading = true;
    notifyListeners();

    String result = await _authenticationService.loginUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    isLoading = false;
    notifyListeners();

    return result;
  }

  Future<bool> logOut() async {
    isLoading = true;
    bool result = await _authenticationService.logOutUser();
    isLoading = false;
    notifyListeners();
    return result;
  }

  // Util
  Future<bool> requestPasswordResetEmail({required String email}) async {
    isLoading = true;
    notifyListeners();

    bool result =
        await _authenticationService.requestPasswordResetEmail(email: email);

    isLoading = false;
    notifyListeners();

    return result;
  }

// Phone Number Auth
  late String _verificationId;
  late String _fullName;

  Future requestOTP(phoneNumber, context, fullName) async {
    isLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) async {
            PhoneAuthCredential local = PhoneAuthProvider.credential(
                verificationId: _verificationId,
                smsCode: phoneAuthCredential.smsCode!);

            signInWithPhoneAuthCredential(local, context);
          },
          verificationFailed: (verificationFailed) async {
            isLoading = false;

            kShowToast(message: "Please try again!");
          },
          codeSent: (verificationId, resendingToken) async {
            Navigator.pushNamed(context, OTPVerification.routeName);
            _verificationId = verificationId;
            _fullName = fullName;
          },
          // timeout: Duration(seconds: 120),
          codeAutoRetrievalTimeout: (verificationId) async {});
    } catch (e) {
      kShowToast(message: "Invalid OTP");
      rethrow;
    }
    isLoading = false;
    notifyListeners();
  }

  Future verifyOTP(code, context) async {
    try {
      isLoading = true;
      notifyListeners();

      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code);

      signInWithPhoneAuthCredential(
        phoneAuthCredential,
        context,
      );
    } catch (_) {}

    notifyListeners();
    isLoading = false;
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential, context) async {
    try {
      final fbUser =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

      FirebaseAuth.instance.currentUser!.updateDisplayName(_fullName);

      // update user name

      var currentUser = fbUser.user;
      if (currentUser != null) {
        // redirect user to home page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );

        // cache user info
        Map<String, dynamic> userInfo = {
          "email": FirebaseAuth.instance.currentUser!.email,
          "userName": FirebaseAuth.instance.currentUser!.displayName,
          "profileImage": FirebaseAuth.instance.currentUser!.photoURL
        };
        _utilService.saveInfoToCache(
            value: userInfo.toString(), key: "currentUser");

        kShowToast(message: "Registration successful");
        notifyListeners();
      } else {
        kShowToast(message: "Invalid OTP");
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();

      kShowToast(message: "Invalid OTP");
    }
  }
}
