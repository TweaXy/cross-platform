import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:tweaxy/constants/theme_validations.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key, required this.setBirthDate});
  final Function setBirthDate;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: DatePickerWidget(
        pickerTheme: DateTimePickerTheme(
            backgroundColor: Colors.transparent,
            dividerColor: forgroundColorTheme(context),
            itemTextStyle: TextStyle(color: forgroundColorTheme(context))),
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
