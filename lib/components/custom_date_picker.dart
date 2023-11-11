import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_date_picker_style.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';


class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  void _setBirthDate(DateTime newDateTime) {
    setState(() {
      _dateFieldcontroller.text = newDateTime.toString().split(' ')[0];
    });
  }

  void _showdatepicker(BuildContext contex) {
    setState(() {
      _birthdateshow = true;
    });
  }

  bool _birthdateshow = false;
  final TextEditingController _dateFieldcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _birthdateshow = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _dateFieldcontroller,
            label: "birth date",
            onTap: _showdatepicker,
            validatorFunc: () {},
            unreadable: true,
          ),
        ),
        if (_birthdateshow) CustomDatePicker(setBirthDate: _setBirthDate)
      ],
    );
  }
}
