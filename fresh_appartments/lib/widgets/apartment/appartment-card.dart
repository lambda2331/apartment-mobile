import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh_appartments/entity/Apartment.dart';
import 'package:fresh_appartments/widgets/apartment/apartement-info.dart';
import 'package:fresh_appartments/widgets/apartment/apartment-image.dart';
import 'package:fresh_appartments/widgets/apartment/apartment-description.dart';
import 'package:fresh_appartments/widgets/apartment/apartment-link.dart';

class ApartmentCard extends StatelessWidget {
  final Apartment apartment;
  const ApartmentCard({Key key, @required this.apartment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: <Widget>[
          AppartmentImage(images: apartment.images),
          ApartmentInfo(
            date: apartment.time,
            prices: apartment.price,
          ),
          ApartmentDescription(
            description: apartment.street,
            margin: EdgeInsets.only(left: 20, right: 20, top: 15),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ApartmentDescription(
            description: apartment.text,
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            style: TextStyle(fontSize: 18),
          ),
          ApartmentLink(
            url: apartment.url,
            website: apartment.website,
          )
        ]));
  }
}
