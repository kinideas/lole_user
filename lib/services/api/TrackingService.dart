import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrackingService {
  final String fileName = "TrackingService.dart";
  final String className = "TrackingService";

  final String driverId = "eBigVDsg2mTiywb41GaN";
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection("location");

  Future updateLocation(
      {required String longitude, required String latitude}) async {
    await locationCollection
        .doc(driverId)
        .set({"long": longitude, "lat": latitude}).onError(
      (e, _) => print("Error writing document: $e"),
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDriverLocation() {
    return FirebaseFirestore.instance
        .collection('location')
        .doc(driverId)
        .snapshots();
  }
  Future<Map<String,dynamic>> getDriverLocation(String driverId) async {
    var doc=await locationCollection.doc(driverId).get();
      var hey= doc.data() as Map<String,dynamic>;
      print('called');
    return hey;
  }
}
