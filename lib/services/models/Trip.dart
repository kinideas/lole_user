import 'package:json_annotation/json_annotation.dart';

part 'Trip.g.dart';

@JsonSerializable()
class Trip {
  final double tripDuration;
  final String tripPickUpAddress;
  final String tripDropOffAddress;
  final double tripPickUpLong;
  final double tripPickUpLat;
  final double tripDropOffLong;
  final double tripDropOffLat;
  final double tripDistance;
  final String tripStatus;
  final String tripType;
  final double tripPrice;
// driver info
  final String driverId;
  final String vehicleId;

// Item
  final String itemType;
  final String itemDescription;
  final double itemWeight;

  // Personnel
  final String senderFullName;
  final String senderPhone;
  final String receiverFullName;
  final String receiverPhone;
  final String packageId;

  Trip({
    required this.itemDescription,
    required this.itemType,
    required this.itemWeight,
    required this.tripPickUpLat,
    required this.tripDistance,
    required this.tripDropOffAddress,
    required this.tripDropOffLat,
    required this.tripDropOffLong,
    required this.tripDuration,
    required this.tripPickUpAddress,
    required this.tripPickUpLong,
    required this.tripPrice,
    required this.tripStatus,
    required this.tripType,
    required this.driverId,
    required this.vehicleId,
    required this.receiverFullName,
    required this.receiverPhone,
    required this.senderFullName,
    required this.senderPhone,
    required this.packageId,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return _$TripFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
