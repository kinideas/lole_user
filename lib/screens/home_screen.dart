import 'package:flutter/material.dart';
import 'package:lole/screens/auth/login_screen.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthenticationProvider _authenticationProvider;

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: Center(
          child: InkWell(
            onTap: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );

              await _authenticationProvider.logOut();
            },
            child: const Text("Logout"),
          ),
        ),
      ),
    );
  }
}
