// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      tripDuration: (json['trip_duration'] as num).toDouble(),
      tripPickUpAddress: json['pick_up_address'] as String,
      tripDropOffAddress: json['drop_off_address'] as String,
      tripPickUpLong: (json['pick_up_lon'] as num).toDouble(),
      tripPickUpLat: (json['pick_up_lat'] as num).toDouble(),
      tripDropOffLong: (json['drop_off_lon'] as num).toDouble(),
      tripDropOffLat: (json['drop_off_lat'] as num).toDouble(),
      tripDistance: (json['distance'] as num).toDouble(),
      tripStatus: json['trip_status'] as String,
      tripType: json['trip_type'] as String,
      senderFullName: json['sender_fullname'] as String,
      senderPhone: json['sender_phone_number'] as String,
      receiverFullName: json['reciver_fullname'] as String,
      receiverPhone: json['reciver_phone_number'] as String,
      itemType: json['cargo_type'] as String,
      itemDescription: json['cargo_description'] as String,
      itemWeight: (json['cargo_weight'] as num).toDouble(),
      tripPrice: (json['trip_price'] as num).toDouble(),
      driverId: json['driver_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      packageId: json['package_pricing_id'] as String,
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'trip_duration': instance.tripDuration,
      'pick_up_address': instance.tripPickUpAddress,
      'drop_off_address': instance.tripDropOffAddress,
      'pick_up_lon': instance.tripPickUpLong,
      'pick_up_lat': instance.tripPickUpLat,
      'drop_off_lon': instance.tripDropOffLong,
      'drop_off_lat': instance.tripDropOffLat,
      'distance': instance.tripDistance,
      'trip_status': instance.tripStatus,
      'trip_type': instance.tripType,

      //
      'sender_fullname': instance.senderFullName,
      'sender_phone_number': instance.senderPhone,
      'reciver_fullname': instance.receiverFullName,
      'reciver_phone_number': instance.receiverPhone,

      'cargo_type': instance.itemType,
      'cargo_description': instance.itemDescription,
      'cargo_weight': instance.itemWeight,
      'trip_price': instance.tripPrice,
      'driver_id': instance.driverId,
      'vehicle_id': instance.vehicleId,
      "package_pricing_id": instance.packageId

      //
    };
