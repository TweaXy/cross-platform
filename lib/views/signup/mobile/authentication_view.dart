import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/mobile/not_robot_view.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({super.key});
  final SignupService service = SignupService(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        key: const ValueKey("AuthenticationAppbar"),
        iconButton: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(
            Icons.close,
            color: forgroundColorTheme(context),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: CustomHeadText(
                              textValue: "Authenticate your account",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: CustomParagraphText(
                              textValue:
                                  "We need to make sure that you're a real person",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        alignment: Alignment.center,
                        child: WebViewPlus(
                          key: const ValueKey("AuthenticationWebView"),
                          javascriptMode: JavascriptMode.unrestricted,
                          backgroundColor: Colors.transparent,
                          onWebViewCreated: (controller) {
                            controller.loadUrl("assets/web/index.html");
                          },
                          javascriptChannels: {
                            JavascriptChannel(
                                name: 'Captcha',
                                onMessageReceived:
                                    (JavascriptMessage message) async {
                                  log("message ${message.message.toString()}");
                                  try {
                                    dynamic response =
                                        await service.authentication();

                                    if (response is String) {
                                      showToastWidget(
                                        CustomToast(
                                          message: response,
                                        ),
                                        position: ToastPosition.bottom,
                                        duration: const Duration(seconds: 2),
                                      );
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotRobotView()));
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                }),
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
