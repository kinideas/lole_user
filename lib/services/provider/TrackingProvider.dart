import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lole/services/api/TrackingService.dart';
import 'package:lole/services/models/Trip.dart';

class TrackingProvider extends ChangeNotifier {
  bool isLoading = false;

  final TrackingService _trackingService = TrackingService();

  Future updateLocation(
      {required String longitude, required String latitude}) async {
    isLoading = true;
    notifyListeners();

    await _trackingService.updateLocation(
        longitude: longitude, latitude: latitude);

    isLoading = false;
    notifyListeners();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDriverLocation() {
    isLoading = true;
    

    var result = _trackingService.streamDriverLocation();

    isLoading = false;
    

    return result;
  }
  Future<List<Map<String, dynamic>>> getAllDriversLocation() async {
    isLoading = true;
    notifyListeners();

    var drivers = await _trackingService.getAllDriverLocations();

    isLoading = false;
    notifyListeners();

    return drivers;
  }
  Future updateJobForDriver(
      {required String jobId, required String driverId,required Trip trifInfo}) async {
    isLoading = true;
    notifyListeners();

    await _trackingService.updateJobForDriver(jobId: jobId, driverId: driverId,tripInfo: trifInfo);

    isLoading = false;
    notifyListeners();
  }
}
