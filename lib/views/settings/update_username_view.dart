import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/update_username_components/update_username_button.dart';
import 'package:tweaxy/components/settings/update_username_components/update_username_disabled_textfield.dart';
import 'package:tweaxy/components/settings/update_username_components/update_username_enabled_textfield.dart';
import 'package:tweaxy/services/temp_user.dart';

class UpdateUsernameView extends StatefulWidget {
  const UpdateUsernameView({super.key});

  @override
  State<UpdateUsernameView> createState() => _UpdateUsernameViewState();
}

class _UpdateUsernameViewState extends State<UpdateUsernameView> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    controller.text = TempUser.username;
    controller.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = controller.text.trim().length > 5;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(
        title: 'Change username',
        showUsername: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: UpdateUsernameDisabledTextfield(),
            ),
            Form(
              key: _formKey,
              child: UpdateUsernameEnabledTextfield(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0, bottom: 3.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.23,
                child: UpdateUsernameButton(
                  isButtonEnabled: isButtonEnabled,
                  username: controller.text,
                  formKey: _formKey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
