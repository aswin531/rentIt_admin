import 'package:flutter/material.dart';
import 'package:rent_it_admin_web/styles/custom_text_styles.dart';

Future<void> showErrorDialog(BuildContext context, String message) async {
  return showDialog<void>(
    //barrierColor: const Color.fromARGB(0, 184, 184, 184),
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: BorderSide.strokeAlignCenter,
        // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          'Error',
          style: CustomTextStyles.heading2,
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
