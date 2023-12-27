import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/settings/save_settings_button.dart';
import 'package:tweaxy/components/settings/update_username_components/update_username_web_textfield.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/cubits/setting-web-cubit/settings_web_cubit.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_cubit.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/services/update_username_service.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';
import 'package:tweaxy/shared/keys/update_username_keys.dart';

class UpdaateUsernameWebView extends StatefulWidget {
  const UpdaateUsernameWebView({super.key});

  @override
  State<UpdaateUsernameWebView> createState() => _UpdaateUsernameWebViewState();
}

class _UpdaateUsernameWebViewState extends State<UpdaateUsernameWebView> {
  TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  final UpdateUsernameService service = UpdateUsernameService(Dio());


@override
  void initState() {
    super.initState();
    usernameController.text = TempUser.username;
    usernameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = usernameController.text.trim().length > 4;
    });
  }
  
  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          key: const ValueKey(SettingsKeys.backIcon),
          onPressed: () {
            BlocProvider.of<SettingsWebCubit>(context).toggleMenu(0);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            "Change username",
            textAlign: TextAlign.left),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: CustomUpdateUsernameTextField(
                key: const ValueKey(UpdateUsernameKeys.updateUsernameTextfield),
                controller: usernameController,
              ),
            ),
            const Divider(endIndent: 0, indent: 0, height: 30),

             Align(
              alignment: Alignment.bottomRight,
              child: SaveSettingsButton(
                key: const ValueKey(UpdateUsernameKeys.updateUsernameButton),
                isButtonEnabled: isButtonEnabled,
                onPressed: () async {
                  try {
                    dynamic response = await service.updateUsername(null,usernameController.text);
                       
                    if (response is String) {
                      showToastWidget(
                        CustomWebToast(
                          message: response,
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    } else if (mounted) {
                       BlocProvider.of<UpdateUsernameCubit>(context)
                          .updateUsername(usernameController.text);
                      BlocProvider.of<SettingsWebCubit>(context).toggleMenu(0);
                      showToastWidget(
                        const CustomWebToast(
                          message: "Username updated successfully.",
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );

                    }
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                },
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}
