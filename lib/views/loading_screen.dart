import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.asyncCall});
  final bool asyncCall;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      opacity: 1,
      progressIndicator: SizedBox(
        height: 65,
        width: 65,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: [Colors.black]),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 50,
              height: 50,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
      inAsyncCall: asyncCall,
      child: const Placeholder(),
    );
  }
}
