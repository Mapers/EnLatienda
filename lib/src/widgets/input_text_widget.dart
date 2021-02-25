import 'package:flutter/material.dart';

class InputTextWidget extends StatefulWidget {

  final String label;
  final Function(String) validator;
  final bool isSecure;
  final TextInputType inputType;
  final double fontSize;
  final Color colorText;

  const InputTextWidget({Key key,@required this.label,@required this.validator, this.isSecure = false, this.inputType = TextInputType.text, this.fontSize = 17, this.colorText = Colors.black54}) : super(key: key);

  @override
  _InputTextWidgetState createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      obscureText: widget.isSecure,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(fontSize: widget.fontSize, color: widget.colorText),
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.colorText)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.colorText)
        )
      ),
    );
  }
}