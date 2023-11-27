import 'package:flutter/material.dart';
import 'package:tweaxy/models/app_icons.dart';

class AddTweetView extends StatefulWidget {
  const AddTweetView({super.key});

  @override
  State<AddTweetView> createState() => _AddTweetViewState();
}

class _AddTweetViewState extends State<AddTweetView> {
  final TextEditingController _tweetController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    _tweetController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _tweetController.text.isNotEmpty &&
          _tweetController.text.length <= 280;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonEnabled
                            ? const Color(0xFF1e9aeb)
                            : const Color.fromARGB(255, 156, 203, 250),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 2.0),
                        child: Text(
                          "Post",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02,
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage('assets/girl.jpg'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.84,
                    child: TextFormField(
                      controller: _tweetController,
                      //280 char max
                      // minLines: 2,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'What\'s happening?',
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 18),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                AppIcon.image,
                color: Color(0xFF1e9aeb),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                AppIcon.gif,
                color: Color(0xFF1e9aeb),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.poll_outlined,
                color: Color(0xFF1e9aeb),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.emoji_emotions_outlined,
                color: Color(0xFF1e9aeb),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF1e9aeb),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
