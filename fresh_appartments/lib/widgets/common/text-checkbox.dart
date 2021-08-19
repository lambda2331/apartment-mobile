import 'package:flutter/material.dart';

class TextCheckbox extends StatefulWidget {
  final String text;
  final Function onChange;
  final bool value;

  TextCheckbox({Key key, @required this.text, this.onChange, this.value})
      : super(key: key);

  @override
  _TextCheckboxState createState() => _TextCheckboxState();
}

class _TextCheckboxState extends State<TextCheckbox> {
  bool _value;

  @override
  void initState() {
    super.initState();
    this.setState(() {
      _value = widget.value;
    });
  }

  @override
  void didUpdateWidget(covariant TextCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);

    this.setState(() {
      _value = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.onChange(widget.text, _value);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _value ? Colors.green.shade700 : Colors.white,
            border: Border.all(color: Colors.green.shade700)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _value
              ? Text(
                  widget.text,
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  widget.text,
                  style: TextStyle(color: Colors.green.shade700),
                ),
        ),
      ),
    );
  }
}
