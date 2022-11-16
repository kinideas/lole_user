import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lole/components/placeSearchWidget.dart';
import 'package:uuid/uuid.dart';
import '../components/textformfield.dart';
import '../services/api/placesapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
static String routeName = "/home";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    
   getLocation();
    super.initState();
  }
 
double lati=8.980603;
double long=38.757759;
//LatLng lat= const LatLng(8.980603, 38.757759);
  getLocation()async{
   LocationPermission permission1 = await Geolocator.requestPermission();
    // LocationPermission permission = await Geolocator.checkPermission();
    
 Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
 //LatLng loc=LatLng(position.latitude,position.longitude);
 setState(() {
   lati=position.latitude;
   long=position.longitude;
 });
 print(lati);
  }
  
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController nameController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  TextEditingController weightController=TextEditingController();
  TextEditingController itemtypeController=TextEditingController();
  TextEditingController placesController=TextEditingController();

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
  @override
  Widget build(BuildContext context) {
     final CameraPosition _kGooglePlex =   CameraPosition(
    target: LatLng(lati,long),
    zoom: 15,
  );
    return Scaffold(
      
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(height: 100,
            width: 350,
                   decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),

            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                   ),
            child: InkWell(
              onTap: () {
                 showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context, builder: (context) {

              return Container(
               decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
               ),
                height: 700,
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                  
                      children: [
                          SizedBox(height: 5,),
                      Container(
                        height: 5,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('Receiver Info',style: TextStyle(color: Colors.white),),
                    TextfieldHomepage(nameController: nameController,hintext: 'Receiver\'s name',type: TextInputType.name,),
                    TextfieldHomepage(nameController: numberController,hintext: 'Phone Number',type: TextInputType.number,),
                     Text('Item Info',style: TextStyle(color: Colors.white),),
                     TextfieldHomepage(nameController: weightController, hintext: 'Weight in KG',type: TextInputType.number,),
                     TextfieldHomepage(nameController: itemtypeController, hintext: 'Item Type',type: TextInputType.name,),
                     SizedBox(height: 10,),
                     TextFormField(
                      
                              controller: placesController,
                              readOnly: true,
                              onTap: () async {
                                // generate a new token here
                                final sessionToken = Uuid().v4();
                                final Suggestion? result = await showSearch(
                                  context: context,
                                  delegate: AddressSearch( sessionToken:sessionToken ),
                                );
                                 // ignore: unused_local_variable
                                 
                                // This will change the text displayed in the TextField
                                if (result != null) {
                                  setState(() {
                    placesController.text = result.description;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                icon: Container(
                                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                                 
                                  width: 420,
                                  height: 40,
                                  child: Center(child: Text(placesController.text==''?'Select destination':placesController.text,style: TextStyle(color: Colors.black),))
                                ),
                                hintText: "Enter Destination",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                              ),
                            ),
                            SizedBox(height: 25,),
                            InkWell(
                              onTap: () {
                                if(nameController.text.isNotEmpty&&numberController.text.length==10&&itemtypeController.text.isNotEmpty&&weightController.text.isNotEmpty&&placesController.text.isNotEmpty)
                                {
                                   setState(() {
                                   nameController.text='';
                                   numberController.text='';
                                   weightController.text='';
                                   itemtypeController.text='';
                                   placesController.text='';

                                 });
                                Navigator.pop(context);
                                }
                                else {
                                  
                                }
                                
                               
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                color: Color(0XFF674FA1)
                                ),
                                height: 50,
                                width: 300,
                                child: Center(child: Text("Submit Details",style: TextStyle(color: Colors.white),)),
                              ),
                            )
                      ],
                    ),
                  ),
                ),
              );
            },);
              },
              child: Column(
             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 5,),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Center(child: Text("Enable Location")),
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(color: Colors.white,
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
