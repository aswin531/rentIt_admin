import 'package:firebase_auth/firebase_auth.dart';
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

String getSignInErrorMessage(Exception e) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'user-not-found':
        return 'User not found. Please check your email address.';
      case 'wrong-password':
        return 'Invalid password. Please try again.';
      default:
        return 'Failed to sign in. Please try again.';
    }
  } else {
    // Handle other exception types if needed
    return 'An unexpected error occurred. Please try again.';
  }
}

