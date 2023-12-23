import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_cubit.dart';
import 'package:tweaxy/views/chat/web/diect_message_web.dart';

class NoConversationsWebView extends StatelessWidget {
  const NoConversationsWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomHeadText(
                textValue: 'Select a message',
                textAlign: TextAlign.left,
                size: 32,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: CustomParagraphText(
                  textValue:
                      'Choose from existing conversations, start a new one, or just keep swimming.',
                  textAlign: TextAlign.left,
                  size: 18,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final exampleCubit = context.read<ChatWebCubit>();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BlocProvider<ChatWebCubit>.value(
                        value: exampleCubit,
                        child: const DirectMesssageWeb(),
                      );
                    },
                    barrierColor: const Color.fromARGB(100, 97, 119, 129),
                    barrierDismissible: false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1e9aeb),
                  shadowColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  elevation: 20,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "New message",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 19),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
