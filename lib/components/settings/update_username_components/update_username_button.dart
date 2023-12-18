import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/services/update_username_service.dart';

class UpdateUsernameButton extends StatelessWidget {
  UpdateUsernameButton(
      {super.key, required this.username, required this.isButtonEnabled});
  final String username;
  final bool isButtonEnabled;
  final UpdateUsernameService service = UpdateUsernameService(Dio());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          dynamic response = await service.updateUsername(username);

          if (response is String) {
            showToastWidget(
              CustomToast(
                message: response,
              ),
              position: ToastPosition.bottom,
              duration: const Duration(seconds: 2),
            );
          } else {
            showToastWidget(
              const CustomToast(message: "Username updated successfully"),
              position: ToastPosition.bottom,
              duration: const Duration(seconds: 2),
            );
            TempUser.username = username;
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        } catch (e) {
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
      child: const Text("Done",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}
