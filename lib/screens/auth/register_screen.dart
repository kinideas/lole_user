import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lole/components/section_title.dart';
import 'package:lole/constants/colors.dart';
import 'package:lole/screens/auth/components/custom_form_field.dart';
import 'package:lole/screens/auth/components/primary_button.dart';
import 'package:lole/screens/auth/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/register";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameInputController = TextEditingController();
    TextEditingController lastNameInputController = TextEditingController();
    TextEditingController emailInputController = TextEditingController();
    TextEditingController passwordInputController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        color: lolePrimaryColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spacer
              const SizedBox(
                height: 150,
              ),

              // Title
              const SectionTitle(text: "Register"),

              // Spacer
              const SizedBox(
                height: 32,
              ),

              // First Name Input
              CustomFormField(
                controller: firstNameInputController,
                hintText: "First Name",
                displayIcon: const Icon(
                  Icons.person,
                ),
              ),

              // Spacer
              const SizedBox(
                height: 26,
              ),

              // First Name Input
              CustomFormField(
                controller: lastNameInputController,
                hintText: "Last Name",
                displayIcon: const Icon(
                  Icons.person,
                ),
              ),

              // Spacer
              const SizedBox(
                height: 26,
              ),

              // Email Input
              CustomFormField(
                controller: emailInputController,
                hintText: "Email",
                displayIcon: const Icon(
                  Icons.email,
                ),
              ),

              // Spacer
              const SizedBox(
                height: 26,
              ),

              // Password Input
              CustomFormField(
                controller: passwordInputController,
                hintText: "Password",
                displayIcon: const Icon(
                  Icons.password,
                ),
              ),

              // Spacer
              const SizedBox(
                height: 45,
              ),

              // Register Button
              CustomPrimaryButton(
                label: "Register",
                onTap: () {},
              ),

              // spacer
              const SizedBox(
                height: 30,
              ),

              // Register
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(text: "  "),
                        TextSpan(
                          text: "Sign In",
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
      ),
    );
  }
}
