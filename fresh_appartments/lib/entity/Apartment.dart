import 'package:json_annotation/json_annotation.dart';

part 'apartment.g.dart';

@JsonSerializable(nullable: false)
class Apartment {
  final String url;
  final String text;
  final String street;
  final List<String> price;
  final String time;
  final List<String> images;
  final String website;

  Apartment(
      {this.url,
      this.text,
      this.street,
      this.price,
      this.time,
      this.images,
      this.website});

  factory Apartment.fromJson(Map<String, dynamic> json) =>
      _$ApartmentFromJson(json);
  Map<String, dynamic> toJson() => _$ApartmentToJson(this);
}
