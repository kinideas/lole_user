import 'package:flutter/material.dart';
import 'package:lole/components/functions.dart';
import 'package:lole/components/lole_logo.dart';
import 'package:lole/components/lole_spinner.dart';
import 'package:lole/components/section_title.dart';
import 'package:lole/constants/colors.dart';
import 'package:lole/screens/auth/components/custom_form_field.dart';
import 'package:lole/screens/auth/components/primary_button.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatefulWidget {
  static String routeName = "/resetPassword";

  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  late AuthenticationProvider _authenticationProvider;
  TextEditingController emailInputController = TextEditingController();

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
      appBar: AppBar(
        title: const Text("Reset Password"),
        backgroundColor: lolePrimaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        color: lolePrimaryColor,
        child: Column(
          children: [
            // Spacer
            const SizedBox(
              height: 40,
            ),

            // Logo
            const Center(
              child: LoleLogo(),
            ),

            // Spacer
            const SizedBox(
              height: 24,
            ),

            // Title
            const SectionTitle(text: "Reset Your Password"),

            // Spacer
            const SizedBox(
              height: 32,
            ),

            // Email Input
            CustomFormField(
              controller: emailInputController,
              hintText: "Email",
              displayIcon: const Icon(Icons.email_rounded),
            ),

            // Spacer
            const SizedBox(
              height: 45,
            ),

            // Button

            InkWell(
              onTap: () async {
                if (emailInputController.text == "") {
                  kShowToast(message: "Email is required");
                } else {
                  bool result =
                      await _authenticationProvider.requestPasswordResetEmail(
                          email: emailInputController.text);

                  if (result == true) {
                    emailInputController.text = "";
                  }
                }
              },
              child: Consumer<AuthenticationProvider>(
                builder: (context, authenticationProvider, _) {
                  if (authenticationProvider.isLoading) {
                    return const LoleSpinner();
                  } else {
                    return const CustomPrimaryButton(
                      label: "Reset Password",
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
