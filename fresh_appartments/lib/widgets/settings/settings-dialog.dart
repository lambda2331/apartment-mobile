import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh_appartments/widgets/settings/settings.dart';

class SettingsDiaolg extends StatelessWidget {
  final Function refreshCallback;
  const SettingsDiaolg({this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Настройки'),
      content: Settings(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            refreshCallback();
          },
          child: Text('Применить'),
        ),
      ],
    );
  }
}
