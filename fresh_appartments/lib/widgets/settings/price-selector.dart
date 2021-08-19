import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PriceSelector extends StatefulWidget {
  PriceSelector({Key key}) : super(key: key);

  @override
  _PriceSelectorState createState() => _PriceSelectorState();
}

class _PriceSelectorState extends State<PriceSelector> {
  final priceFrom = TextEditingController();
  final priceTo = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSelectedPrice();
  }

  getSelectedPrice() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var prices = _prefs.getStringList('price') ?? [];

    if (prices.length > 0) {
      this.setState(() {
        priceFrom.text = prices[0];
        priceTo.text = prices[1];
      });
    }
  }

  updateStorage(price) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setStringList('price', price);
  }

  Widget priceInputWiget(text, callback, controller) {
    return Container(
      width: 70,
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: text,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onSubmitted: callback,
      ),
    );
  }

  updateFromPrice(price) {
    if (price.length > 0) {
      priceFrom.text = price;
    } else {
      priceFrom.text = '';
    }
    updateStorage(selectedPrice);
  }

  updateToPrice(price) {
    if (price.length > 0) {
      priceTo.text = price;
    } else {
      priceTo.text = '';
    }

    updateStorage(selectedPrice);
  }

  get selectedPrice => [priceFrom.text, priceTo.text];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(
                'Цена (USD): ',
                style: TextStyle(fontSize: 18),
              )),
          Row(
            children: <Widget>[
              priceInputWiget('От', updateFromPrice, priceFrom),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              priceInputWiget('До', updateToPrice, priceTo),
            ],
          )
        ]));
  }
}
