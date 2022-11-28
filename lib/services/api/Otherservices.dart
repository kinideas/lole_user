import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:lole/constants/constants.dart';
import 'package:lole/services/models/Package.dart';

class OtherServices {
  Future<List<Package>> fetchPackageData() async {
    String api = '$loleBaseUrl/packagespricing';
    Response response = await get(Uri.parse(api));
    List<Package> packages=[];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
     
 packages= data.map((package){
     return  Package.fromJson(package);
  }).toList();
    }
    return packages;
  }

  Future<void> sendNotificaton(tokens)async{
    await post(
                    Uri.parse("https://fcm.googleapis.com/fcm/send"),
                    headers: {
                      "Authorization":
                          "key=AAAAiN-jv14:APA91bGwT7QANWGSJokTEiF-RkuEQIVpghqxUSwAZt8uPZqikILJp_spQ0s1qp1SbvhQPU8W_RBt23gAtznmUaYNcQVF4GP-w4OK_JXIKJAElDalhXyWlTjgFnI-JwFKwo-bainxTT1B",
                      "Content-Type": "application/json"
                    },
                    body: jsonEncode({
                      "registration_ids":tokens,
                      "notification": {
      "title": "Lole Driver",
      "body": "You got a job",
      "mutable_content": true,
      "sound": "Tri-tone"
      },
                      "collapse_key": "8b990f5a-78fc-4bad-b242-ffc740a750fb",
                      "data": {"message": "message to device"}
                    }),
                  );  }
}
