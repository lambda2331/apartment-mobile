part of 'Apartment.dart';

Apartment _$ApartmentFromJson(Map<String, dynamic> json) {
  return Apartment(
      url: json['url'] as String,
      text: json['text'] as String,
      street: json['street'] as String,
      price: json['price'].cast<String>(),
      time: json['time'] as String,
      images: json['images'].cast<String>(),
      website: json['website'] as String);
}

Map<String, dynamic> _$ApartmentToJson(Apartment instance) => <String, dynamic>{
      'url': instance.url,
      'text': instance.text,
      'street': instance.street,
      'price': instance.price.toString(),
      'time': instance.time,
      'images': instance.images.toString(),
      'website': instance.website
    };
