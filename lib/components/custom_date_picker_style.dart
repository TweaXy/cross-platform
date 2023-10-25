import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key, required this.setBirthDate});
  final Function setBirthDate;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

Color setcolor(BuildContext context) {
  return Brightness.dark == Theme.of(context).brightness
      ? Colors.white
      : Colors.black;
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: DatePickerWidget(
        pickerTheme: DateTimePickerTheme(
            backgroundColor: Colors.transparent,
            dividerColor: setcolor(context),
            itemTextStyle: TextStyle(color: setcolor(context))),
        dateFormat: "MMM-dd-yyyy",
        lastDate: DateTime.now().add(const Duration(days: 2)),
        firstDate: DateTime(1950, 5, 3),
        initialDate: DateTime.now().subtract(const Duration(days: 3 * 365)),
        looping: true,
        onChange: (DateTime newDate, _) {
          widget.setBirthDate(newDate);
        },
      ),
    );
  }
}
