import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lole/constants/routes.dart';
import 'package:lole/firebase_options.dart';
import 'package:lole/services/api/UtilService.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:lole/services/provider/TrackingProvider.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => TrackingProvider()),
      ],
      child: const LoleApp(),
    ),
  );
}

class LoleApp extends StatefulWidget {
  const LoleApp({Key? key}) : super(key: key);

  @override
  State<LoleApp> createState() => _LoleAppState();
}

class _LoleAppState extends State<LoleApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  // ignore: must_call_super
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lole Delivery',
      initialRoute: "/",
      routes: appRouter.allRoutes,
      navigatorKey: navigatorKey,
    );
  }
}

Future<Map<String, dynamic>> checkIfAuthenticated() async {
  UtilService utilService = UtilService();
  String result = await utilService.getInfoFromCache(key: "currentUser");

  return jsonDecode(result);
}
