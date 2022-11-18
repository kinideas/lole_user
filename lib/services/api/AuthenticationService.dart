import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:lole/constants/constants.dart';
import 'package:lole/constants/functions.dart';
import 'package:lole/services/api/ErrorLoggingService.dart';
import 'package:lole/services/api/UtilService.dart';

class AuthenticationService {
  //
  final String fileName = "AuthenticationService.dart";
  final String className = "AuthenticationService";

  // Util Service
  final UtilService _utilService = UtilService();
  final ErrorLoggingApiService _errorLoggingApiService =
      ErrorLoggingApiService();

  Future<String> registerUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber}) async {
    try {
      // try firebase auth call
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
      Map<String, dynamic> userInfo = {
        "email": FirebaseAuth.instance.currentUser!.email,
        "userName": FirebaseAuth.instance.currentUser!.displayName,
        "profileImage": FirebaseAuth.instance.currentUser!.photoURL
      };
      _utilService.saveInfoToCache(
          value: userInfo.toString(), key: "currentUser");

      kShowToast(message: "Registration successful");

      return "Successfully Registered";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use" ||
          e.code == "email-already-exists") {
        kShowToast(message: "Email already registered. Login");
        return "Email already registered";
      } else if (e.code == "invalid-display-name") {
        kShowToast(message: "Invalid Full Name");
        return "Invalid Full Name";
      } else if (e.code == "invalid-email") {
        kShowToast(message: "Invalid Full Name");
        return "Email in use";
      } else if (e.code == "invalid-password" || e.code == "weak-password") {
        kShowToast(message: "Weak Password");
        return "Weak Password";
      } else {
        kShowToast(message: "Something went wrong");
        return "Something went wrong";
      }
    } catch (e) {
      _errorLoggingApiService.logErrorToServer(
        fileName: fileName,
        functionName: "registerUserWithEmailAndPassword",
        errorInfo: e.toString(),
      );
      kShowToast(message: "Something went wrong");
      return 'Unknown Error Occurred';
    }
  }

  Future<bool> saveUserToServer() async {
    final Response response = await post(
      Uri.parse("$loleBaseUrl/client"),
    );

    return true;
  }

  Future<String> loginUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // connect with firebase
      var possibleUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: password,
      );

      if (possibleUser.user != null) {
        var currentUser = possibleUser.user;

        Map<String, dynamic> userInfo = {
          "email": FirebaseAuth.instance.currentUser!.email,
          "userName": FirebaseAuth.instance.currentUser!.displayName,
          "profileImage": FirebaseAuth.instance.currentUser!.photoURL
        };
        _utilService.saveInfoToCache(
            value: userInfo.toString(), key: "currentUser");
      }

      return "Successfully Logged In";
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        return "Invalid Credentials";
      } else if (e.code == "invalid-email") {
        _errorLoggingApiService.logErrorToServer(
          fileName: fileName,
          functionName: "logIn",
          errorInfo: e.toString(),
        );
        return "Something Went Wrong";
      } else {}
    } catch (e) {
      _errorLoggingApiService.logErrorToServer(
        fileName: fileName,
        functionName: "logIn",
        errorInfo: e.toString(),
      );
    }
    return "Something Went Wrong";
  }

  Future loginUserWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();

      GoogleSignInAccount? _user;

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var fbUser = await FirebaseAuth.instance.signInWithCredential(credential);
      var currentUser = fbUser.user!;
      // cache user info
      Map<String, dynamic> userInfo = {
        "email": FirebaseAuth.instance.currentUser!.email,
        "userName": FirebaseAuth.instance.currentUser!.displayName,
        "profileImage": FirebaseAuth.instance.currentUser!.photoURL
      };
      _utilService.saveInfoToCache(
          value: userInfo.toString(), key: "currentUser");

      return "Successfully Logged In";
    } catch (e) {
      print(e);
      _errorLoggingApiService.logErrorToServer(
        fileName: fileName,
        functionName: "logIn",
        errorInfo: e.toString(),
      );
      kShowToast(message: "Could not log you in");
      return e.toString();
    }
  }

  Future<bool> logOutUser() async {
    // logout firebase
    await FirebaseAuth.instance.signOut();

    // logout google sign in
    try {
      final googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      _utilService.saveInfoToCache(value: "", key: "currentUser");

      return true;
    } catch (e) {
      _errorLoggingApiService.logErrorToServer(
        fileName: fileName,
        functionName: "logOut",
        errorInfo: e.toString(),
      );
    }

    return false;
  }

  Future requestPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      kShowToast(message: "Password reset email sent");
      return true;
    } catch (e) {
      _errorLoggingApiService.logErrorToServer(
        fileName: fileName,
        functionName: "sendResetPasswordEmail",
        errorInfo: e.toString(),
        remark: "Password Reset",
        className: className,
      );
      kShowToast(message: "Could not sent reset email");
      return false;
    }
  }

  // Phone Number Auth

}
