
import 'package:flutter/cupertino.dart';
import 'package:lole/services/api/Otherservices.dart';
import 'package:lole/services/models/Package.dart';

class OtherProvider extends ChangeNotifier{
  List<Package> packages=[];
  Future<List<Package>> getPackages()async{
    packages=await OtherServices().fetchPackageData();
    notifyListeners();
    return packages;
  }
  Future<void> notifyDrivers(driverTokens)async{
    await OtherServices().sendNotificaton(driverTokens);
  }
}