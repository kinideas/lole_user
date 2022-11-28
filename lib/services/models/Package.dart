import 'package:json_annotation/json_annotation.dart';

part 'Package.g.dart';
@JsonSerializable()
class Package{
final String id;
final String package_name;
final String package_description;
final String base_price;
final String price_perKmforkg;

Package({required this.id, required this.package_name, required this.package_description, required this.base_price, required this.price_perKmforkg});
factory Package.fromJson(Map<String, dynamic> json) {
    return _$PackageFromJson(json);
  }
Map<String, dynamic> toJson() => _$PackageToJson(this);
}