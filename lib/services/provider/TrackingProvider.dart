import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lole/services/api/TrackingService.dart';

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
    notifyListeners();

    var result = _trackingService.streamDriverLocation();

    isLoading = false;
    notifyListeners();

    return result;
  }
}
