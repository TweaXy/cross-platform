import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/mobile/signup_code_verification.dart';

class NotRobotView extends StatefulWidget {
  const NotRobotView({super.key});

  @override
  State<NotRobotView> createState() => _NotRobotViewState();
}

class _NotRobotViewState extends State<NotRobotView>
    with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
      duration: const Duration(milliseconds: 400), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();

    checkController.addStatusListener(
      (status2) {
        if (status2 == AnimationStatus.completed) {
          scaleController.reverse();
          checkController.reverse();
          Future.delayed(const Duration(milliseconds: 795), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SingupCodeVerificationView(),
              ),
            );
          });
        }
      },
    );
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 140;
    double iconSize = 108;
    return Scaffold(
      appBar: CustomAppbar(
        key: const ValueKey("notRobotAppbar"),
        iconButton: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: forgroundColorTheme(context),
          ),
        ),
      ),
      body: Center(
        heightFactor: 2.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: scaleAnimation,
              child: Column(
                children: [
                  Container(
                    height: circleSize,
                    width: circleSize,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: FadeTransition(
                        opacity: checkAnimation,
                        child: Icon(Icons.check,
                            color: Colors.white, size: iconSize)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomParagraphText(
                      textValue:
                          "You've proven you're a human.\nContinue your action.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
