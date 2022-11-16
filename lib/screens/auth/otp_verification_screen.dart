import 'package:flutter/material.dart';
import 'package:lole/components/lole_logo.dart';
import 'package:lole/components/lole_spinner.dart';
import 'package:lole/components/section_title.dart';

import 'package:lole/constants/colors.dart';
import 'package:lole/screens/auth/otp_request_screen.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPVerification extends StatefulWidget {
  static String routeName = '/otp/verification';

  const OTPVerification({Key? key}) : super(key: key);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController code = TextEditingController();
  final _codeFormKey = GlobalKey<FormState>();
  late PinTheme submittedPinTheme;

  late PinTheme defaultPinTheme;
  late PinTheme focusedPinTheme;
  String error = '';

  void validator(context) async {
    AuthenticationProvider loginProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    await loginProvider.verifyOTP(code.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: lolePrimaryColor,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 16),
          child: Stack(
            children: [
              SingleChildScrollView(
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
                      text: "Verification",
                    ),

                    // Spacer
                    const SizedBox(height: 25),

                    //
                    Consumer<AuthenticationProvider>(
                      builder: (context, loginProvider, _) {
                        return Pinput(
                          defaultPinTheme: const PinTheme(
                            width: 35,
                            height: 40,
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: loleSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          focusedPinTheme: const PinTheme(
                            width: 25,
                            height: 56,
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: loleSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: BoxDecoration(),
                          ),
                          submittedPinTheme: const PinTheme(
                            width: 25,
                            height: 56,
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: loleSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: BoxDecoration(),
                          ),
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          length: 6,
                          onCompleted: (pin) async {
                            await loginProvider.verifyOTP(pin, context);
                          },
                        );
                      },
                    ),

                    // Spacer
                    const SizedBox(
                      height: (12),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        "We've sent an SMS with an activation code to your phone",
                        style: TextStyle(
                          color: loleSecondaryColor.withOpacity(0.75),
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Spacer
                    const SizedBox(height: 12),

                    // Resend
                    Consumer<AuthenticationProvider>(
                      builder: (context, authenticationProvider, _) {
                        if (authenticationProvider.isLoading) {
                          return const LoleSpinner();
                        } else {
                          return InkWell(
                            child: const Text(
                              "Didn't receive code ?",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () async {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OTPRequestScreen(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),

                    // Description Text
                  ],
                ),
              ),
              Positioned(
                top: 25,
                left: 10,
                right: 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
