import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/not_robot_view.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: CustomAppbar(
                        key: const ValueKey("AuthenticationAppbar"),
                        iconButton: IconButton(
                          onPressed: () {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          icon: Icon(
                            Icons.close,
                            color: forgroundColorTheme(context),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: CustomHeadText(
                        textValue: "Authenticate your account",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: CustomParagraphText(
                        textValue:
                            "We need to make sure that you're a real person",
                        textAlign: TextAlign.center,
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
                              onMessageReceived: (JavascriptMessage message) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotRobotView()));
                              },
                            ),
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
