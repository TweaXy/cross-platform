import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/custom_settings_text_field.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/update_password_service.dart';
import 'package:tweaxy/shared/keys/update_password_keys.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  //Todo : Add validation to the textfields ;add API;
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
      appBar: const SettingsAppBar(
        title: "Update Password",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomSettingsTextField(
                key: const ValueKey(UpdatePasswordKeys.oldPassword),
                labelText: "Current Password",
                hintText: '',
                controller: currentPasswordController,
                isPassword: true,
              ),
              CustomSettingsTextField(
                key: const ValueKey(UpdatePasswordKeys.newPassword),
                labelText: "New Password",
                hintText: 'At least 8 characters',
                controller: newPasswordController,
                isPassword: true,
              ),
              CustomSettingsTextField(
                key: const ValueKey(UpdatePasswordKeys.confirmPassword),
                labelText: "Confirm Password",
                hintText: 'At least 8 characters',
                controller: confirmPasswordController,
                isPassword: true,
              ),
              ElevatedButton(
                key: const ValueKey(UpdatePasswordKeys.updatePasswordButton),
                onPressed: () async {
                  try {
                    dynamic response = await service.updatePassword(
                      null,
                        oldPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text);
                    if (response is String) {
                      showToastWidget(
                        CustomToast(
                          message: response,
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    } else if (mounted) {
                      Navigator.pop(context);
                      showToastWidget(
                        const CustomToast(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonEnabled
                      ? const Color(0xFF1e9aeb)
                      : const Color.fromARGB(255, 156, 203, 250),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Update password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 19),
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
