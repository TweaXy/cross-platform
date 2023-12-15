import 'package:flutter/material.dart';

class CustomAddReplyRow extends StatelessWidget {
  const CustomAddReplyRow({super.key, required this.replyto});
  final List<String> replyto;

  @override
  Widget build(BuildContext context) {
    return replyto.isEmpty
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: VerticalDivider(
                  width: 58,
                  endIndent: 0,
                  indent: 0,
                  thickness: 2,
                  color: Colors.blueGrey[200],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: Text(
                  "Replying to ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                  ),
                ),
              ),
              InkWell(
                child: Text(
                  "@${replyto[0]}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                  ),
                  maxLines: 2,
                ),
                onTap: () {},
              )
            ],
          );
  }
}
