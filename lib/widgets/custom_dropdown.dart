import 'package:flutter/material.dart';

import '../app/data/services/api_constants.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool isRequired;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropdownItems =
        items.asMap().entries.map((entry) {
          final index = entry.key;
          final choice = entry.value;

          return DropdownMenuItem<String>(
            value: index == 0 ? null : choice,
            enabled: index != 0,
            child: Text(
              choice,
              style: TextStyle(color: index == 0 ? kGreen : Colors.black),
            ),
          );
        }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value == items[0] ? null : value,
          // prevent default select
          items: dropdownItems,
          onChanged: onChanged,
          validator:
              isRequired
                  ? (val) {
                    if (val == null || val.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  }
                  : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15,
            ),
            hintText: items[0],
            hintStyle: const TextStyle(color: kGrey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: kGreen, width: 1.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        ),
      ],
    );
  }
}
