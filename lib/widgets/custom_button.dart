import 'package:flutter/material.dart';

import '../app/data/services/api_constants.dart';

class CustomButton extends StatefulWidget {
  CustomButton({required this.callBackFunction, required this.label});

  final VoidCallback callBackFunction;
  final String label;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.callBackFunction();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 17),
        child: Text(
          widget.label,
          style: TextStyle(color: kWhite, fontSize: 15),
        ),
      ),
    );
  }
}
