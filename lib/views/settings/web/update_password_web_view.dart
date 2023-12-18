import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/settings/save_settings_button.dart';
import 'package:tweaxy/components/settings/update_password_web_components/custom_text_field.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/cubits/setting-web-cubit/settings_web_cubit.dart';
import 'package:tweaxy/services/update_password_service.dart';
import 'package:tweaxy/shared/keys/update_password_keys.dart';

class UpdatePasswordWebView extends StatefulWidget {
  const UpdatePasswordWebView({super.key});

  @override
  State<UpdatePasswordWebView> createState() => _UpdatePasswordWebViewState();
}

class _UpdatePasswordWebViewState extends State<UpdatePasswordWebView> {
  bool isButtonEnabled = false;

  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  UpdatePasswordService service = UpdatePasswordService(Dio());

  @override
  void initState() {
    super.initState();
    currentPasswordController.addListener(_updateButtonState);
    newPasswordController.addListener(_updateButtonState);
    confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = currentPasswordController.text.isNotEmpty &&
          newPasswordController.text.length > 7 &&
          confirmPasswordController.text.length ==
              newPasswordController.text.length;
    });
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
          "Change Your Password",
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            CustomUpdatePasswordTextField(
              key: const ValueKey(UpdatePasswordKeys.oldPassword),
              labelText: "Current Password",
              isPassword: true,
              controller: currentPasswordController,
            ),
            const Divider(endIndent: 0, indent: 0, height: 30),
            CustomUpdatePasswordTextField(
              key: const ValueKey(UpdatePasswordKeys.newPassword),
              labelText: "New Password",
              isPassword: true,
              controller: newPasswordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: CustomUpdatePasswordTextField(
                key: const ValueKey(UpdatePasswordKeys.confirmPassword),
                labelText: "Confirm Password",
                isPassword: true,
                controller: confirmPasswordController,
              ),
            ),
            const Divider(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveSettingsButton(
                key: const ValueKey(UpdatePasswordKeys.updatePasswordButton),
                isButtonEnabled: isButtonEnabled,
                onPressed: () async {
                  try {
                    dynamic response = await service.updatePassword(
                        oldPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text);
                    if (response is String) {
                      showToastWidget(
                        CustomWebToast(
                          message: response,
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    } else if (mounted) {
                      BlocProvider.of<SettingsWebCubit>(context).toggleMenu(0);
                      showToastWidget(
                        const CustomWebToast(
                          message: "Password updated successfully.",
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
