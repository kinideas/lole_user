import 'package:flutter/material.dart';
import 'package:lole/components/functions.dart';
import 'package:lole/components/lole_spinner.dart';
import 'package:lole/components/section_title.dart';
import 'package:lole/constants/colors.dart';
import 'package:lole/screens/auth/components/custom_form_field.dart';
import 'package:lole/screens/auth/components/primary_button.dart';
import 'package:lole/screens/auth/login_screen.dart';
import 'package:lole/screens/home_screen.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthenticationProvider _authenticationProvider;
  TextEditingController firstNameInputController = TextEditingController();

  TextEditingController lastNameInputController = TextEditingController();

  TextEditingController emailInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController phoneNumberInputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

              // Phone Input
              CustomFormField(
                controller: phoneNumberInputController,
                hintText: "Phone Number",
                displayIcon: const Icon(
                  Icons.phone,
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
              InkWell(
                onTap: () async {
                  // null first name
                  if (firstNameInputController.text == "") {
                    kShowToast(message: "First Name is required");
                  }

                  // null last name
                  else if (lastNameInputController.text == "") {
                    kShowToast(message: "First Name is required");
                  }

                  // null email
                  else if (emailInputController.text == "") {
                    kShowToast(message: "Email is required");
                  }

                  // null email
                  else if (passwordInputController.text == "") {
                    kShowToast(message: "Password is required");
                  }
                  // success
                  else {
                    String result = await _authenticationProvider
                        .registerWithEmailAndPassword(
                      email: emailInputController.text,
                      password: passwordInputController.text,
                      firstName: firstNameInputController.text,
                      lastName: firstNameInputController.text,
                    );

                    if (result == "Successfully Registered") {
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
                        label: "Register",
                      );
                    }
                  },
                ),
              ),

              // spacer
              const SizedBox(
                height: 30,
              ),

              // Register
              Center(
                child: InkWell(
                  onTap: () {
                    // null pa
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
