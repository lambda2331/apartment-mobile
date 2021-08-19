import 'package:flutter/material.dart';
import 'package:fresh_appartments/widgets/common/text-checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomsSelector extends StatefulWidget {
  RoomsSelector({Key key}) : super(key: key);

  @override
  _RoomsSelectorState createState() => _RoomsSelectorState();
}

class _RoomsSelectorState extends State<RoomsSelector> {
  List<String> selectedRooms = [];
  final options = ['1', '2', '3', '4'];

  @override
  void initState() {
    super.initState();
    getSelectedRooms();
  }

  getSelectedRooms() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    this.setState(() {
      selectedRooms = _prefs.getStringList('rooms') ?? [];
    });
  }

  handleRoomsUpdate(room, isSelected) {
    isSelected ? addRoom(room) : removeRoom(room);
  }

  removeRoom(room) {
    this.setState(() {
      selectedRooms.remove(room);

      updateStorage(selectedRooms);
    });
  }

  bool isSelectedRoom(room) {
    return selectedRooms.contains(room);
  }

  addRoom(room) {
    this.setState(() {
      if (!selectedRooms.contains(room)) {
        selectedRooms.add(room);
      }

      updateStorage(selectedRooms);
    });
  }

  updateStorage(rooms) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setStringList('rooms', rooms);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(
                'Кол. комнат: ',
                style: TextStyle(fontSize: 18),
              )),
          Row(
            children: options
                .map((item) => Padding(
                      child: TextCheckbox(
                        text: item,
                        onChange: handleRoomsUpdate,
                        value: isSelectedRoom(item),
                      ),
                      padding: EdgeInsets.only(right: 5),
                    ))
                .toList(),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ]));
  }
}
