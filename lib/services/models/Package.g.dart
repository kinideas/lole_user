// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: json['id'].toString(),
      package_name: json['package_name'].toString(),
      package_description: json['package_description'].toString(),
      base_price: json['base_price'].toString(),
      price_perKmforkg: json['price_perKmforkg'].toString() ,
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'package_name': instance.package_name,
      'package_description': instance.package_description,
      'base_price': instance.base_price,
      'price_perKmforkg': instance.price_perKmforkg,
    };
