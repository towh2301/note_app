import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/routes/routes.dart';
import 'package:note_app/views/register_page.dart';
import 'dart:developer' as dev show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(title: const Text('Login')),
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
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                dev.log(userCredential.toString());

                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  // If user is verified, send them to note view page
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        noteViewRoute, (route) => false);
                  }
                } else {
                  // If user is not verified, send them to verify email page
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute, (route) => false);
                  }
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  dev.log('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  dev.log('Wrong password ');
                } else if (e.code == 'invalid-email') {
                  dev.log('Invalid email');
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Register"),
          )
        ],
      ),
    );
  }
}
