import 'package:flutter/material.dart';
import 'package:tweaxy/Components/web_dialog_sign_in.dart';

class WebMainDialog extends StatelessWidget {
  const WebMainDialog({
    super.key,
    required this.dialogWidth,
    required this.dialogHeight,
    required this.isDarkMode,
  });

  final double dialogWidth;
  final double dialogHeight;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
            body: WebDialogSignIn(
                dialogWidth: dialogWidth, isDarkMode: isDarkMode),
          ),
        ),
      ),
    );
  }
}
