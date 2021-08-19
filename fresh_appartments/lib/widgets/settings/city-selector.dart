import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitySelector extends StatefulWidget {
  CitySelector({Key key}) : super(key: key);

  @override
  _CitySelectorState createState() => _CitySelectorState();
}

final defaultCity = 'minsk';

class _CitySelectorState extends State<CitySelector> {
  var city = null;

  final options = ['brest', 'vitebsk', 'gomel', 'grodno', 'minsk', 'mogilev'];

  final cityNames = {
    'minsk': 'Минск',
    'grodno': 'Гродно',
    'gomel': 'Гомель',
    'vitebsk': 'Витебск',
    'brest': 'Брест',
    'mogilev': 'Могилев'
  };

  @override
  void initState() {
    super.initState();
    getSelectedCity();
  }

  getSelectedCity() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    this.setState(() {
      city = _prefs.getString('city') ?? defaultCity;
    });
  }

  setSelectedCity(value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString('city', value);
    this.setState(() {
      city = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(flex: 2, child: Text('Город: ', style: TextStyle(fontSize: 18))),
      Expanded(
        flex: 2,
        child: DropdownButton(
            isExpanded: true,
            value: city,
            onChanged: (value) {
              setSelectedCity(value);
            },
            items: options.map((item) {
              return DropdownMenuItem(
                  value: item,
                  child: Text(
                    cityNames[item],
                    textWidthBasis: TextWidthBasis.longestLine,
                  ));
            }).toList()),
      )
    ]);
  }
}
