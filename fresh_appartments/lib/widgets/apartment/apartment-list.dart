import 'package:flutter/material.dart';
import 'package:fresh_appartments/entity/Apartment.dart';
import 'package:fresh_appartments/widgets/settings/city-selector.dart';
import 'package:fresh_appartments/widgets/settings/settings-dialog.dart';
import 'dart:convert';
import 'appartment-card.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> configureURLParams() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  final city = _prefs.getString('city') ?? defaultCity;
  final rooms = _prefs.getStringList('rooms') ?? [];
  var price = _prefs.getStringList('price') ?? [];

  var urlParams = ['city=' + city];
  price = price.where((element) => element.toString().length > 0).toList();
  if (rooms.length > 0) {
    urlParams.add('rooms=' + rooms.join(','));
  }

  if (price.length > 0) {
    urlParams.add('price=' + price.join(','));
  }

  return urlParams.join('&');
}

Future<List<dynamic>> fetchApartments() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  final selectedWebsite = _prefs.getString('websites') ?? 'all';
  final urlParams = await configureURLParams();

  final websitesMapping = {
    'all': ['kufar', 'irr'],
    'kufar': ['kufar'],
    'irr': ['irr']
  };
  
  List<http.Response> responses = await Future.wait(
      websitesMapping[selectedWebsite].map((website) => http.get(
          'https://apartments-api-node-js.herokuapp.com/{website}?'
              .replaceFirst('{website}', website)
              .replaceFirst('{params}', urlParams))));

  return responses.map((response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }).toList();
}

class ApartmentList extends StatefulWidget {
  ApartmentList({Key key}) : super(key: key);

  @override
  _ApartmentListState createState() => _ApartmentListState();
}

class _ApartmentListState extends State<ApartmentList> {
  Future<List<dynamic>> apartmentList;

  @override
  void initState() {
    super.initState();
    apartmentList = fetchApartments();
  }

  Future<void> refreshApartments() {
    this.setState(() {
      apartmentList = fetchApartments();
    });

    return Future.value(apartmentList);
  }

  showSettingsDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SettingsDiaolg(
            refreshCallback: this.refreshApartments,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: apartmentList,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState != ConnectionState.waiting) {
            final apartmentList = snapshot.data
                .expand((list) => list)
                .toList()
                .map((item) => Apartment.fromJson(item))
                .toList();

            apartmentList.sort((apartmentA, apartmentB) =>
                apartmentA.time.compareTo(apartmentB.time));
            return Stack(
              children: <Widget>[
                RefreshIndicator(
                  onRefresh: () => refreshApartments(),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 90),
                    itemCount: apartmentList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                      height: 1,
                      color: Colors.transparent,
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ApartmentCard(apartment: apartmentList[index]);
                    },
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    // add your floating action button
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: FloatingActionButton(
                        onPressed: () {
                          showSettingsDialog(context);
                        },
                        child: Icon(Icons.settings),
                        backgroundColor: Colors.green.shade700,
                      ),
                    )),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
