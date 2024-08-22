import 'package:flutter/material.dart';
import 'package:whatsapp/common/utils/coolors.dart';
import 'package:whatsapp/common/utils/extensions/custom_theme_extension.dart';

showLoadingDialog({
  required BuildContext context,
   required String message,
})async {
  return await showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Coolors.greenDark,
                  ),
                ),
                Expanded(child: Text(message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: context.theme.greyColor,
                  height: 1.5
                ),))
              ],
            ),
          ]
        ),
      );

  });
}