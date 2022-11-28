import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lole/services/models/Trip.dart';

class TrackingService {
  final String fileName = "TrackingService.dart";
  final String className = "TrackingService";

  final String driverId = "eBigVDsg2mTiywb41GaN";
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection("location");
final CollectionReference jobCollection =
      FirebaseFirestore.instance.collection("jobs");
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
  Future<List<Map<String, dynamic>>> getAllDriverLocations() async {
    List<Map<String, dynamic>> drivers = [];
    String currentDriverId = "";
    QuerySnapshot documents =
        await FirebaseFirestore.instance.collection('drivers').get();

    documents.docs.forEach((doc) {
      currentDriverId = doc.id;
      drivers.add({
        "id": currentDriverId,
        "long": doc['long'],
        "lat": doc['lat'],
        "isOnline": doc['isOnline'],
        "fcmToken":doc['fcmToken']
      });
    });

    return drivers;
  }
  Future updateJobForDriver(
      {required String jobId, required String driverId, required Trip tripInfo }) async {
    DocumentSnapshot data = await jobCollection.doc(jobId).get();
    List drivers = [];

    if (data.data() != null) {
      Map<String, dynamic> jobInfo = data.data() as Map<String, dynamic>;
      drivers = jobInfo['selectedDrivers'] ?? [];
    }

    List filteredDrivers =
        drivers.where((element) => element == driverId).toList();

    if (filteredDrivers.isEmpty) {
      drivers.add(driverId);
    }

    await jobCollection.doc(jobId).set({
      "selectedDrivers": drivers,
      "tripInfo":tripInfo.toJson()
    }).onError(
      (e, _) => print("Error writing document: $e"),
    );
  }
  
}
