import 'package:flutter/material.dart';
import 'package:fresh_appartments/widgets/apartment/apartment-list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text('Fresh apartments'),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Card(
                    margin: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      child: Image.asset(
                        'images/logo.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
              backgroundColor: Colors.green.shade700,
            ),
            body: Container(
              margin: EdgeInsets.only(top: 20),
              child: ApartmentList(),
            )));
  }
}
