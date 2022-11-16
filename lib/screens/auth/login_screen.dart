import 'package:flutter/material.dart';
import 'package:lole/components/functions.dart';
import 'package:lole/components/lole_logo.dart';
import 'package:lole/components/lole_spinner.dart';
import 'package:lole/components/section_title.dart';
import 'package:lole/screens/auth/components/custom_form_field.dart';
import 'package:lole/screens/auth/otp_request_screen.dart';
import 'package:lole/screens/auth/password_reset_screen.dart';
import 'package:lole/screens/auth/components/primary_button.dart';
import 'package:lole/screens/auth/register_screen.dart';
import 'package:lole/screens/home_screen.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthenticationProvider _authenticationProvider;
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  @override
  void initState() {
    _authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lole Logo
            const Center(
              child: LoleLogo(),
            ),

            // Spacer
            const SizedBox(
              height: 40,
            ),

            // Title
            const SectionTitle(text: "Sign In"),

            // Spacer
            const SizedBox(
              height: 28,
            ),

            // Email Input
            CustomFormField(
              controller: emailInputController,
              hintText: "Email",
              displayIcon: const Icon(Icons.email_rounded),
            ),

            // Spacer
            const SizedBox(
              height: 24,
            ),

            // Password Input
            CustomFormField(
              controller: passwordInputController,
              hintText: "Password",
              displayIcon: const Icon(Icons.password),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PasswordResetScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Spacer
            const SizedBox(
              height: 20,
            ),

            // Sign In Button
            InkWell(
              onTap: () async {
                if (emailInputController.text == "") {
                  kShowToast(message: "Email is required");
                }

                // null password
                else if (passwordInputController.text == "") {
                  kShowToast(message: "Password is required");
                }

                // success
                else {
                  String result =
                      await _authenticationProvider.loginWithEmailAndPassword(
                    email: emailInputController.text,
                    password: passwordInputController.text,
                  );

                  if (result == "Successfully Logged In") {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                }
              },
              child: Consumer<AuthenticationProvider>(
                builder: (context, authenticationProvider, _) {
                  if (authenticationProvider.isLoading) {
                    return const LoleSpinner();
                  } else {
                    return const CustomPrimaryButton(
                      label: "Sign In",
                    );
                  }
                },
              ),
            ),

            // Spacer
            const SizedBox(
              height: 28,
            ),

            // Separator
            const Center(
              child: Text(
                "or",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            // Spacer
            const SizedBox(
              height: 26,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google Login
                InkWell(
                  onTap: () async {
                    String result =
                        await _authenticationProvider.loginWithGoogle();

                    if (result == "Successfully Logged In") {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/icons/GoogleAuth.png"),
                  ),
                ),

                // Spacer
                const SizedBox(
                  width: 36,
                ),

                // Phone Login
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OTPRequestScreen(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/icons/PhoneAuth.png"),
                  ),
                ),
              ],
            ),

            // Spacer
            const SizedBox(
              height: 30,
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: Center(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(text: "  "),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
