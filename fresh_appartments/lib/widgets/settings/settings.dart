import 'package:flutter/material.dart';
import 'package:fresh_appartments/widgets/settings/city-selector.dart';
import 'package:fresh_appartments/widgets/settings/price-selector.dart';
import 'package:fresh_appartments/widgets/settings/rooms-selector.dart';
import 'package:fresh_appartments/widgets/settings/website-selector.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: Column(
        children: <Widget>[
          WebsiteSelector(),
          CitySelector(),
          RoomsSelector(),
          PriceSelector(),
        ],
      ),
    );
  }
}
