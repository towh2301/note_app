import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev show log;

import 'package:note_app/routes/routes.dart';
import 'package:note_app/views/show_errors_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            enableSuggestions: false, // disable suggestions
            autocorrect: false,
            keyboardType: TextInputType.emailAddress, // email onl
            decoration: const InputDecoration(
              hintText: 'Email',
              labelText: 'Email',
            ),
            controller: _email,
          ),
          TextField(
            obscureText: true, // hide password
            enableSuggestions: false, // disable suggestions
            autocorrect: false, // disable auto correct
            decoration: const InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
            ),
            controller: _password,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final email = _email.text;
                final password = _password.text;
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                dev.log(userCredential.toString());

                // Send verification email
                FirebaseAuth.instance.currentUser?.sendEmailVerification();
                if (context.mounted) {
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  showErrorDialog(
                      context, 'The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  showErrorDialog(
                      context, 'The account already exists for that email.');
                } else if (e.code == 'Invalid-email') {
                  showErrorDialog(context, 'Invalid email.');
                } else {
                  showErrorDialog(context, 'Error: ${e.code}');
                }
              } catch (e) {
                showErrorDialog(context, 'Error: $e');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Return to Login'),
          )
        ],
      ),
    );
  }
}
