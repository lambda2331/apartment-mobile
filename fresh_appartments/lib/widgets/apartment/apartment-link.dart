import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApartmentLink extends StatelessWidget {
  final String hintText = 'Кликни сюда \u{2192}';
  final String url;
  final String website;

  final Map<String, Color> websiteColor = {
    'kufar': Colors.green,
    'irr': Colors.red
  };

  final Map<String, String> websiteName = {'kufar': ' K', 'irr': ' Irr'};

  ApartmentLink({Key key, this.url, this.website}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(hintText,
                style: TextStyle(color: Colors.black.withOpacity(0.5))),
            InkWell(
              child: Text(
                websiteName[website],
                style: TextStyle(
                    color: websiteColor[website],
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await launch(url);
              },
            )
          ],
        ));
  }
}
