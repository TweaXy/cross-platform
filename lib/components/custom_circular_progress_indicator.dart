import 'package:flutter/material.dart';

class CusotmCircularProgressIndicator extends StatefulWidget {
  const CusotmCircularProgressIndicator({
    super.key,
    required TextEditingController tweetController,
  }) : _tweetController = tweetController;

  final TextEditingController _tweetController;

  @override
  State<CusotmCircularProgressIndicator> createState() =>
      _CusotmCircularProgressIndicatorState();
}

class _CusotmCircularProgressIndicatorState
    extends State<CusotmCircularProgressIndicator> {
  int textState =
      0; // 0(blue) --> (0-259) , 1 (Orange) --> (260 - 279) , 2 (Red) --> (>=280)
  int textLength = 0;

  @override
  void initState() {
    // textState = widget._tweetController.text.length;
    widget._tweetController.addListener(_updateCircularProgressState);

    super.initState();
  }

  void _updateCircularProgressState() {
    textLength = widget._tweetController.text.length;
    setState(() {
      textState = textLength < 260
          ? 0
          : textLength < 280
              ? 1
              : 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: widget._tweetController.text.length / 280,
          backgroundColor: Colors.black12,
          color: textState == 0
              ? const Color(0xFF1e9aeb)
              : textState == 1
                  ? Colors.orange
                  : Colors.red,
        ),
        if (textState > 0) Text((280 - textLength).toString()),
      ],
    );
  }
}
