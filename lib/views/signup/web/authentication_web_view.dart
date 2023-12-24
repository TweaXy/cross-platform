import 'dart:developer';
// import 'dart:html' as html if (dart.library.io) 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar_web.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/web/varification_code_web_view.dart';

class AuthenticationWebView extends StatefulWidget {
  const AuthenticationWebView({super.key});

  @override
  State<AuthenticationWebView> createState() => _AuthenticationWebViewState();
}

class _AuthenticationWebViewState extends State<AuthenticationWebView> {
  @override
  void initState() {
    // ignore: undefined_prefixed_name
    // ui.platformViewRegistry.registerViewFactory(
    //   "createdViewId",
    //   (int viewId) => html.IFrameElement()
    //     ..style.height = '100%'
    //     ..style.width = '100%'
    //     ..src =
    //         'assets/web/index.html' // Path to your HTML file containing the reCAPTCHA widget.
    //     ..style.border = 'none',
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.4,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppbarWeb(
                key: const ValueKey("AuthWebAppbar"),
                pageNumber: "3",
                icon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: forgroundColorTheme(context),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                alignment: Alignment.center,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: HtmlElementView(
                    viewType: "createdViewId",
                    onPlatformViewCreated: (id) {
                      log(id.toString());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
