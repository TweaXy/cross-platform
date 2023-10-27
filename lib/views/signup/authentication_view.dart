import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
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
                          javascriptMode: JavascriptMode.unrestricted,
                          backgroundColor: Colors.transparent,
                          onWebViewCreated: (controller) {
                            controller.loadUrl("assets/web/index.html");
                          },
                          javascriptChannels: {
                            JavascriptChannel(
                              name: 'Captcha',
                              onMessageReceived: (JavascriptMessage message) {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CustomPageRoute(
                                        direction: AxisDirection.left,
                                        child: const NotRobotView()));
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
