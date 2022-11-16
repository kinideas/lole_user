import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lole/screens/auth/login_screen.dart';
import 'package:lole/screens/auth/register_screen.dart';
import 'package:lole/screens/homepage.dart';
import 'package:lole/services/api/TrackingService.dart';
import 'package:lole/services/provider/AuthenticationProvider.dart';
import 'package:lole/services/provider/TrackingProvider.dart';
import 'package:provider/provider.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late AuthenticationProvider _authenticationProvider;

  late TrackingProvider _trackingProvider;

  @override
  void initState() {
    _trackingProvider = Provider.of<TrackingProvider>(context, listen: false);
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
        color: Colors.red,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.green,
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: _trackingProvider.streamDriverLocation(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');

                  return Text(snapshot.data!.data().toString());
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  // currentLat++;
                  // currentLong++;
                  // Position position = await Geolocator.getCurrentPosition(
                  //   desiredAccuracy: LocationAccuracy.high,
                  // );
                  // _trackingProvider.updateLocation(
                  //   longitude: position.longitude.toString(),
                  //   latitude: position.latitude.toString(),
                  // );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => HomePage(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 30,
                  color: Colors.blue,
                  child: const Center(child: Text("Update")),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  // // currentLat++;
                  // // currentLong++;
                  // Position position = await Geolocator.getCurrentPosition(
                  //   desiredAccuracy: LocationAccuracy.high,
                  // );
                  // _trackingProvider.updateLocation(
                  //   longitude: position.longitude.toString(),
                  //   latitude: position.latitude.toString(),
                  // );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (builder) => const LoginScreen(),
                    ),
                  );
                  await _authenticationProvider.logOut();
                },
                child: Container(
                  width: 200,
                  height: 30,
                  color: Colors.yellow,
                  child: const Center(child: Text("Logout")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
