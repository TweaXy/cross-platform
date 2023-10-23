import 'package:flutter/material.dart';

class BelowAppBar extends StatefulWidget {
  const BelowAppBar({super.key});

  @override
  State<BelowAppBar> createState() => _BelowBarState();
}

class _BelowBarState extends State<BelowAppBar> {
  //colors to be assigned
  Color borderColorclicked = Color(0xff2a91d6);
  Color borderColorNotClicked = Colors.transparent;
  Color textColorNotClicked = Color(0xff636d76);
  Color textColorClicked = Color(0xff56595c);
//variables to be used
  Color textColor1 = Color(0xff56595c), textColor2 = Color(0xff636d76);
  Color borderColor1 = Color(0xff2a91d6), borderColor2 = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2, color: Color(0xff636d76)),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  textColor1 = textColorClicked;
                  textColor2 = textColorNotClicked;
                  borderColor1 = borderColorclicked;
                  borderColor2 = borderColorNotClicked;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 1),
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 4, color: borderColor1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'For you',
                        style: TextStyle(
                            color: textColor1,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  textColor2 = textColorClicked;
                  textColor1 = textColorNotClicked;
                  borderColor2 = borderColorclicked;
                  borderColor1 = borderColorNotClicked;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 1),
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 4, color: borderColor2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Following',
                        style: TextStyle(
                            color: textColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
