import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it_admin_web/services/firebase/firebase_auth_services.dart';
import 'package:rent_it_admin_web/utils/error_widgets.dart';
import 'package:rent_it_admin_web/utils/list_util_widgets.dart';
import 'package:rent_it_admin_web/views/auth/register.dart';
import 'package:rent_it_admin_web/views/sidebar/sidebar.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _email = ''; // Remove 'final' here
  String _password = ''; // Remove 'final' here

  SignInScreen({super.key}); // Add 'Key?' parameter here

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
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!; // Update _email value here
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!; // Update _password value here
                },
              ),
//                             const SizedBox(height: 20),
ElevatedButton(onPressed: (){
  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
}, child: Text("xignup")),
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
                              context, LoadingInfo('Signing in...')),
                        );
                      },
                    );

                    // Sign in
                    await authService.signInWithEmailAndPassword(_email, _password);

                    // Navigate to SideBarWidgetTest on success
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SideBarWidgetTest()),
                    );

                    // Dismiss loading indicator dialog
                    Navigator.pop(context);
                  } catch (e) {
                    // Show error dialog
                    Navigator.pop(context); // Dismiss loading indicator dialog
                    showErrorDialog(context, e.toString());
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
