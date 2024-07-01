// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it_admin_web/services/firebase/firebase_auth_services.dart';
import 'package:rent_it_admin_web/utils/error_widgets.dart';
import 'package:rent_it_admin_web/utils/list_util_widgets.dart';
import 'package:rent_it_admin_web/views/auth/register.dart';
import 'package:rent_it_admin_web/views/sidebar/sidebar.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: const Text("Sign Up"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
  onPressed: () async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: getLoadingListWidget(
              context,
              LoadingInfo('Signing in...'),
            ),
          );
        },
      );

      // Sign in
      User? user = await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SideBarWidgetTest(),
          ),
        );
      } else {
        // ignore: avoid_print
        print('Error: User object from authService is null.');
      }

      Navigator.pop(context); 
    } on Exception catch (e) {
      Navigator.pop(context);
      showErrorDialog(context, getSignInErrorMessage(e));
    }
  },
  child: const Text('Sign In'),
),

            ],
          ),
        ),
      ),
    );
  }
}
