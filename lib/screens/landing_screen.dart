import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lole/components/lole_spinner.dart';
import 'package:lole/screens/auth/login_screen.dart';
import 'package:lole/screens/home_screen.dart';
import 'package:lole/services/api/UtilService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  static String routeName = "/";

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

Future<bool> checkIfAuthenticated() async {
  try {
    UtilService utilService = UtilService();

    String result = await utilService.getInfoFromCache(key: "currentUser");

    if (result != "" || FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

class _LandingPageState extends State<LandingPage> {
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: checkIfAuthenticated(),
          builder: (context, snapshot) {
            //  loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoleSpinner(),
              );
            }

            // loaded && auth
            else if (snapshot.hasData && snapshot.data! == true) {
              return const HomeScreen();
            }

            // loded & not
            else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
