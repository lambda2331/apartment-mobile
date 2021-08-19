import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebsiteSelector extends StatefulWidget {
  WebsiteSelector({Key key}) : super(key: key);

  @override
  _WebsiteSelectorState createState() => _WebsiteSelectorState();
}

final allWebsites = 'all';
final kufarWebsite = 'kufar';
final irrWebsite = 'irr';


class _WebsiteSelectorState extends State<WebsiteSelector> {
  var website = null;
  final websitesText = {
    allWebsites: 'Все доступные',
    kufarWebsite: 'Куфар',
    irrWebsite: 'Из рук в руки',
  };

  final options = [allWebsites, kufarWebsite, irrWebsite];

  @override
  void initState() {
    super.initState();
    getSelectedWebsite();
  }

  getSelectedWebsite() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    this.setState(() {
      website = _prefs.getString('websites') ?? allWebsites;
    });
  }

  setSelectedWebsite(value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString('websites', value);
    this.setState(() {
      website = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 2, child: Text('Источник: ', style: TextStyle(fontSize: 18))),
      Expanded(
        flex: 2,
        child: DropdownButton(
            isExpanded: true,
            value: website,
            onChanged: (value) {
              setSelectedWebsite(value);
            },
            items: options.map((item) {
              return DropdownMenuItem(
                  value: item, child: Text(websitesText[item]));
            }).toList()),
      )
    ]);
  }
}
