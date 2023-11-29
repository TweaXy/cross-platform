import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';

class DeleteAlertDialogWeb extends StatelessWidget {
  const DeleteAlertDialogWeb({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width * 0.9;
    double screenheight = MediaQuery.of(context).size.width * 0.9;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenwidth * 0.41, vertical: screenheight * 0.1),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        titlePadding: const EdgeInsets.only(bottom: 0, left: 30, top: 30),
        contentPadding:
            const EdgeInsets.only(bottom: 15, left: 30, right: 30, top: 8),
        title: const Text('Delete post?',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(
                    255, 10, 10, 10))), // To display the title it is optional
        content: const Text(
            style:
                TextStyle(fontSize: 16, color: Color.fromARGB(255, 83, 83, 83)),
            'This can\'t be undone and it will be removed from your profile, the timeline of any accounts that follow you, and from search results.'), // Message which will be pop up on the screen
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  backgroundColor: const Color.fromARGB(255, 223, 54, 42),
                  padding: const EdgeInsets.all(20),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  //internal content margin
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showToastWidget(
                      const CustomWebToast(
                        message: 'Your post was deleted',
                      ),
                      position: ToastPosition.bottom,
                      duration: const Duration(seconds: 2));
                },
                child: const Text('Delete',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 25),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  side: const BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 184, 184, 184)),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  //internal content margin
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
