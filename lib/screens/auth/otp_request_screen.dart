import 'package:flutter/material.dart';
import 'package:lole/constants/functions.dart';
import 'package:lole/components/lole_logo.dart';
import 'package:lole/components/lole_spinner.dart';
import 'package:lole/components/section_title.dart';
import 'package:lole/constants/colors.dart';
import 'package:lole/screens/auth/components/custom_form_field.dart';
import 'package:lole/screens/auth/components/primary_button.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:provider/provider.dart';

class OTPRequestScreen extends StatefulWidget {
  const OTPRequestScreen({super.key});
  static String routeName = "/otp";

  @override
  State<OTPRequestScreen> createState() => _OTPRequestScreenState();
}

class _OTPRequestScreenState extends State<OTPRequestScreen> {
  late AuthenticationProvider _authenticationProvider;
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController firstNameInputController = TextEditingController();
  TextEditingController lastNameInputController = TextEditingController();

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
        backgroundColor: lolePrimaryColor,
        title: Text("Phone Login"),
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
              height: 60,
            ),

            // Logo
            const Center(child: LoleLogo()),

            const SizedBox(
              height: 18,
            ),

            // Spacer
            const SectionTitle(
              text: "Register with Phone",
            ),

            const SizedBox(
              height: 24,
            ),

            // first name
            CustomFormField(
              controller: firstNameInputController,
              hintText: "First Name",
              displayIcon: const Icon(Icons.person),
              inputType: "text",
            ),

            const SizedBox(
              height: 24,
            ),

            // last name
            CustomFormField(
              controller: lastNameInputController,
              hintText: "Last Name",
              displayIcon: const Icon(Icons.person),
              inputType: "text",
            ),

            const SizedBox(
              height: 24,
            ),

            // Email Input
            CustomFormField(
              controller: phoneNumberInputController,
              hintText: "911000000",
              displayIcon: const Icon(Icons.phone),
              inputType: "number",
            ),

            const SizedBox(
              height: 36,
            ),

            InkWell(
              onTap: () async {
                if (firstNameInputController == "") {
                  kShowToast(message: "First name is required");
                } else if (lastNameInputController == null) {
                  kShowToast(message: "First name is required");
                } else if (phoneNumberInputController.text == "") {
                  kShowToast(message: "Email is required");
                }

                // // success
                else {
                  String result = await _authenticationProvider.requestOTP(
                    phoneNumber: "+251${phoneNumberInputController.text}",
                    context: context,
                    fullName:
                        "${firstNameInputController.text} ${lastNameInputController.text}",
                  );
                }
              },
              child: Consumer<AuthenticationProvider>(
                builder: (context, authenticationProvider, _) {
                  if (authenticationProvider.isLoading) {
                    return const LoleSpinner();
                  } else {
                    return const CustomPrimaryButton(
                      label: "Login",
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
