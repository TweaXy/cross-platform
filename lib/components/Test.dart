import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12000,
      margin: EdgeInsets.all(10),
      child: Text(
        'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. In a broader sense nature is all physical and abiotic factors of the environment, For the help of readers we have prepared some essential paragraphs on nature, kindly go through it.',
        style: TextStyle(fontSize: 24, color: Colors.yellow),
      ),
      color: Colors.deepOrange[200],
    );
  }
}
