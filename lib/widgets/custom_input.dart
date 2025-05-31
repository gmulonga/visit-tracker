import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/data/services/api_constants.dart';

class InputField extends StatefulWidget {
  InputField({
    required this.hintText,
    this.password = false,
    this.onChanged,
    this.integerOnly = false,
    this.errorText,
    this.isEnabled = true,
    this.controller,
    this.onTap,
    this.isRequired = false,
    this.validator,
    required this.label,
    this.maxLines = 1,
  });

  final String label;
  final String hintText;
  final bool password;
  final ValueChanged<String>? onChanged;
  final bool integerOnly;
  final String? errorText;
  final bool isEnabled;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool isRequired;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? _errorMessage;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(widget.label),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.password ? _obscureText : false,
          enabled: widget.isEnabled,
          onChanged: widget.onChanged,
          validator: widget.validator,

          keyboardType:
              widget.integerOnly ? TextInputType.number : TextInputType.text,
          inputFormatters:
              widget.integerOnly
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: kGreen),
            errorText: _errorMessage,
            suffixIcon:
                widget.password
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: kGreen, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}
