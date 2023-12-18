import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_cubit.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_states.dart';
import 'package:tweaxy/services/update_username_service.dart';

class UpdateUsernameButton extends StatelessWidget {
  UpdateUsernameButton(
      {super.key,
      required this.username,
      required this.isButtonEnabled,
      required this.formKey});
  final String username;
  final bool isButtonEnabled;
  final GlobalKey<FormState> formKey;
  final UpdateUsernameService service = UpdateUsernameService(Dio());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUsernameCubit, UpdateUsernameStates>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
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
                  
                  BlocProvider.of<UpdateUsernameCubit>(context)
                      .updateUsername(username);
                  Navigator.pop(context);
                }
              } catch (e) {
                log(e.toString());
              }
            } else {
              showToastWidget(
                const CustomToast(message: "Please enter a valid username."),
                position: ToastPosition.bottom,
                duration: const Duration(seconds: 2),
              );
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        );
      },
    );
  }
}
