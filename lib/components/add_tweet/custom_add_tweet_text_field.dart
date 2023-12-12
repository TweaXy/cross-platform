import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAddTweetTextField extends StatelessWidget {
  const CustomAddTweetTextField({
    super.key,
    required TextEditingController tweetController,
    required this.isReply,
  }) : _tweetController = tweetController;

  final TextEditingController _tweetController;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _tweetController,
      maxLength: 280,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: 30,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        counterText: '',
        hintText: isReply ? 'Post your reply' : 'What\'s happening?',
        hintStyle: TextStyle(
            color: Colors.black54, fontSize: 18, height: isReply ? 0.5 : 1.85),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
      ),
    );
  }
}
