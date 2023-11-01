import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SettingsAndSupport extends StatefulWidget {
  const SettingsAndSupport({super.key});

  @override
  State<SettingsAndSupport> createState() => _SettingsAndSupportState();
}

class _SettingsAndSupportState extends State<SettingsAndSupport> {
  final List<String> list = const <String>[
    'Settings ',
    'Display',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int selectedvalue;
    String dropdownValue = 'Settings and Support';
    return DropdownButton2<String>(
      hint: const Row(
        children: [
          Icon(
            Icons.list,
            size: 16,
            color: Colors.yellow,
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              'Settings and support',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      isExpanded: true,
      // padding: EdgeInsets.only(left: screenWidth * 0.01, right: 0),
      value: dropdownValue,
      // icon: const Icon(Icons.arrow_drop_down_outlined),
      // elevation: 16,
      style: TextStyle(
        fontSize: 18,
      ),
      underline: Container(),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
