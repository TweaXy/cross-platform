import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAddTweetTextField extends StatelessWidget {
  const CustomAddTweetTextField({
    super.key,
    required TextEditingController tweetController,
  }) : _tweetController = tweetController;

  final TextEditingController _tweetController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _tweetController,
      maxLength: 280,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: 30,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        counterText: '',
        hintText: 'What\'s happening?',
        hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
      ),
    );
  }
}
