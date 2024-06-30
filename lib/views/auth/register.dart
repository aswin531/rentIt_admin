import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it_admin_web/services/firebase/firebase_auth_services.dart';
import 'package:rent_it_admin_web/utils/error_widgets.dart';
import 'package:rent_it_admin_web/utils/list_util_widgets.dart';
import 'package:rent_it_admin_web/views/sidebar/sidebar.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'phonenumber'),
                // obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
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
                              context, LoadingInfo('Signing up...')),
                        );
                      },
                    );

                    // Sign up with retrieved values from controllers
                    await authService.signUpWithEmailAndPassword(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _nameController.text.trim(),
                      _phoneController.text.trim()
                    );

                    // Navigate to SideBarWidgetTest on success
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SideBarWidgetTest(),
                      ),
                    );
                  } catch (e) {
                    // Show error dialog
                    Navigator.pop(context); // Dismiss loading indicator dialog
                    showErrorDialog(context, e.toString());
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
