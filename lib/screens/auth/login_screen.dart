import 'package:flutter/material.dart';
import 'package:lole/components/section_title.dart';
import 'package:lole/screens/auth/components/custom_form_field.dart';
import 'package:lole/screens/auth/components/password_reset_screen.dart';
import 'package:lole/screens/auth/components/primary_button.dart';
import 'package:lole/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailInputController = TextEditingController();
    TextEditingController passwordInputController = TextEditingController();
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
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    110,
                  ),
                ),
                child: Image.asset("assets/icons/Lole.png"),
              ),
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
            CustomPrimaryButton(
              label: "Sign In",
              onTap: () {},
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
              height: 28,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google Login
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset("assets/icons/GoogleAuth.png"),
                  ),
                ),

                // Spacer
                const SizedBox(
                  width: 40,
                ),

                // Phone Login
                InkWell(
                  onTap: () {},
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
              height: 36,
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
