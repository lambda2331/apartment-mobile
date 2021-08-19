import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApartmentInfo extends StatelessWidget {
  final List<String> prices;
  final String date;

  const ApartmentInfo({Key key, this.prices, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> infoList = [
      Text(
        date,
        style: TextStyle(color: Colors.black.withOpacity(0.5)),
      )
    ];

    if (prices.length > 0) {
      final List<Widget> pricesList = [];
      final String mainPrice = prices[0];
      final String secondaryPrice =
          prices.getRange(1, prices.length).join(', ');

      if (mainPrice.length != 0) {
        pricesList.add(Text(
          mainPrice,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
      }

      if (secondaryPrice.length != 0) {
        pricesList.addAll(prices
            .getRange(1, prices.length)
            .map((price) => Text(price,
                style: TextStyle(color: Colors.black.withOpacity(0.5))))
            .toList());
      }

      infoList.add(Column(
        children: pricesList,
        crossAxisAlignment: CrossAxisAlignment.end,
      ));
    }

    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: infoList),
    );
  }
}
