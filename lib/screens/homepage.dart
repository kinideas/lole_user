import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:lole/components/placeSearchWidget.dart';
import 'package:lole/constants/functions.dart';
import 'package:lole/services/api/TrackingService.dart';
import 'package:lole/services/models/Package.dart';
import 'package:lole/services/models/Trip.dart';
import 'package:lole/services/provider/OtherProvider.dart';
import 'package:lole/services/provider/TrackingProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../components/textformfield.dart';
import '../services/api/placesapi.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String routeName = "/home";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getLocation();
    getPackage();
    super.initState();
  }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polyliness = {};

  double lati = 8.980603;
  double long = 38.757759;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  final String apikey = 'AIzaSyC-zuw7SKLgnegrk8lKR_1XlKeEbyrSsOA';

  void _getPolyline(destlat, destlong) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apikey,
      PointLatLng(lati, long),
      PointLatLng(destlat, destlong),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {}
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polyliness[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  List<Package> packages = [];
  getPackage() async {
    packages =
        await Provider.of<OtherProvider>(context, listen: false).getPackages();
  }

//LatLng lat= const LatLng(8.980603, 38.757759);
  getLocation() async {
    LocationPermission permission1 = await Geolocator.requestPermission();
    // LocationPermission permission = await Geolocator.checkPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    markers.add(Marker(
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        markerId: const MarkerId('mine')));
    //LatLng loc=LatLng(position.latitude,position.longitude);
    setState(() {
      lati = position.latitude;
      long = position.longitude;
    });
    print(lati);
  }

  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController itemtypeController = TextEditingController();
  TextEditingController placesController = TextEditingController();

  String? _types;
  String? _valScroll;
  List _typeLists = [
    "Monthly  50 Birr",
    "Yearly 400 Birr",
  ];
  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    weightController.dispose();
    itemtypeController.dispose();
    placesController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  late Suggestion finalresult;
  late String finalSessionToken;
   @override
  Widget build(BuildContext context) {
    LatLng location = LatLng(lati, long);
     LatLng destination=location;
    final CameraPosition kGooglePlex = CameraPosition(
      target: location,
      zoom: 16,
    );
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            polylines: Set<Polyline>.of(polyliness.values),
            // ignore: prefer_collection_literals
            circles: Set.from(
              [
                Circle(
                  circleId: const CircleId('currentCircle'),
                  center: LatLng(location.latitude, location.longitude),
                  radius: 2000,
                  fillColor: Colors.blue.shade100.withOpacity(0.7),
                  strokeColor: Colors.blue.shade100.withOpacity(0.1),
                ),
              ],
            ),
            markers: markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(location.latitude, location.longitude),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: InkWell(
                  onTap: () {
                    // List<Package> pa=await Provider.of<OtherProvider>(context,listen: false).getPackages();
                    // print(pa[0].package_name);
                    //  await TrackingService().getDriverLocation('eBigVDsg2mTiywb41GaN');
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Container(
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            height: 1000,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // const SizedBox(height: 200,),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Text(
                                      'Receiver Info',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextfieldHomepage(
                                      nameController: nameController,
                                      hintext: 'Receiver\'s name',
                                      type: TextInputType.name,
                                    ),
                                    TextfieldHomepage(
                                      nameController: numberController,
                                      hintext: 'Phone Number',
                                      type: TextInputType.number,
                                    ),
                                    const Text(
                                      'Item Info',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextfieldHomepage(
                                      nameController: weightController,
                                      hintext: 'Weight in KG',
                                      type: TextInputType.number,
                                    ),
                                    TextfieldHomepage(
                                      nameController: itemtypeController,
                                      hintext: 'Item Type',
                                      type: TextInputType.name,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor: Colors.white,
                                          isExpanded: true,
                                          hint: const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                21, 8, 0, 8),
                                            child: Text(
                                              "Package Type",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          value: _types,
                                          items: packages.map((value) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.center,
                                              child: Text(
                                                value.package_name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              value: value.package_name,
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _types = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: placesController,
                                      readOnly: true,
                                      onTap: () async {
                                        // generate a new token here
                                        final sessionToken = const Uuid().v4();
                                        final Suggestion? result =
                                            await showSearch(
                                          context: context,
                                          delegate: AddressSearch(
                                              sessionToken: sessionToken),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            placesController.text =
                                                result.description;
                                          });
                                        }

                                        destination =
                                            await PlaceApiProvider(sessionToken)
                                                .getPlaceDetailFromId(
                                                    result!.placeId);
                                                    setState(() {
                                       setState(() {
                                                        
                                        finalresult = result;
                                        finalSessionToken = sessionToken;
                                       },);
                                                    });
                                      },
                                      decoration: InputDecoration(
                                        icon: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white),
                                            width: 420,
                                            height: 40,
                                            child: Center(
                                                child: Text(
                                              placesController.text == ''
                                                  ? 'Select destination'
                                                  : placesController.text,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ))),
                                        hintText: "Enter Destination",
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(
                                            left: 8.0, top: 16.0),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (nameController.text.isNotEmpty &&
                                            numberController.text.length ==
                                                10 &&
                                            itemtypeController
                                                .text.isNotEmpty &&
                                            weightController.text.isNotEmpty &&
                                            placesController.text.isNotEmpty) 
                                            {
                                               
                                          // setState(() {
                                          //   nameController.text = '';
                                          //   numberController.text = '';
                                          //   weightController.text = '';
                                          //   itemtypeController.text = '';
                                          //   placesController.text = '';
                                          // });

                                          setState(() {
                                            markers.add(Marker(
                                                position: destination,
                                                icon: BitmapDescriptor
                                                    .defaultMarkerWithHue(100),
                                                markerId: const MarkerId(
                                                    'receiver')));
                                            polylines.add(Polyline(
                                                polylineId:
                                                    const PolylineId('id'),
                                                color: Colors.red,
                                                points: [
                                                  location,
                                                  destination
                                                ]));
                                          });
                                          List<String> selectedDriver = [];
                                          List<String> notificationTokens = [];
                                          _getPolyline(destination.latitude,
                                              destination.longitude);
                                          List<Map<String, dynamic>>
                                              availableDrivers = await Provider
                                                      .of<TrackingProvider>(
                                                          context,
                                                          listen: false)
                                                  .getAllDriversLocation();

                                          //{id: g0UQ90zZMhT27xaNqrAq, long: 0, lat: 0, isOnline: false}
                                          availableDrivers.forEach((driver) {
                                            double distance = calculateDistance(
                                                location.latitude,
                                                location.longitude,
                                                double.parse(
                                                    driver['lat'].toString()),
                                                double.parse(
                                                    driver['long'].toString()));
                                            if (distance < 2500) {
                                              selectedDriver.add(driver['id']);
                                              notificationTokens
                                                  .add(driver['fcmToken']);
                                            }
                                          });
                                          if(selectedDriver.isEmpty){
                                            kShowToast(message: 'there is no driver in this area');
                                          }
                                          Trip tripInfo = Trip(
                                              itemDescription:
                                                  'itemDescription',
                                              itemType: itemtypeController.text,
                                              itemWeight:12.0,
                                              tripPickUpLat: location.latitude,
                                              tripDistance: 34,
                                              tripDropOffAddress:
                                                  finalresult.description,
                                              tripDropOffLat:
                                                  destination.latitude,
                                              tripDropOffLong:
                                                  destination.longitude,
                                              tripDuration: 23,
                                              tripPickUpAddress: 'Awraris',
                                              tripPickUpLong:
                                                  location.longitude,
                                              tripPrice: 32,
                                              tripStatus: 'tripStatus',
                                              tripType: 'PERSONAL',
                                              driverId: 'g0UQ90zZMhT27xaNqrAq',
                                              vehicleId: 'vehicleId',
                                              receiverFullName:
                                                  nameController.text,
                                              receiverPhone:
                                                  numberController.text,
                                              senderFullName: 'senderFullName',
                                              senderPhone: 'senderPhone',
                                              packageId: 'packageId');
                                          selectedDriver.forEach((id) async {
                                            await Provider.of<TrackingProvider>(
                                                    context,
                                                    listen: false)
                                                .updateJobForDriver(
                                                    jobId: finalSessionToken,
                                                    driverId: id,
                                                    trifInfo: tripInfo);
                                          });

                                          await Provider.of<OtherProvider>(
                                                  context,
                                                  listen: false)
                                              .notifyDrivers(
                                                  notificationTokens);
                                         Navigator.pop(context);
                                        } else {}
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color(0XFF674FA1)),
                                        height: 50,
                                        width: 300,
                                        child: const Center(
                                            child: Text(
                                          "Submit Details",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 420,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: const Center(child: Text("Enable Location")),
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
