import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/routes/routes.dart';
import 'package:note_app/views/login_view.dart';
import 'package:note_app/views/register_page.dart';
import 'dart:developer' as dev show log;

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text(
              "Press the button to send a verification email if you haven't receive it."),
          ElevatedButton.icon(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            icon: const Icon(Icons.email),
            // color: Colors.red[200],
            label: const Text('Send verification email'),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Have problems? Return to Register.'),
          ),
          // FutureBuilder(
          //   builder: (context, snapshot) {
          //     switch (snapshot.connectionState) {
          //       case ConnectionState.none:
          //         final user = FirebaseAuth.instance.currentUser;
          //         Timer(const Duration(seconds: 10), () {
          //           // return const Text('waiting...');
          //           dev.log('waiting...');
          //         });
          //         if (user!.emailVerified) {
          //           return const LoginView();
          //         } else {
          //           return const RegisterView();
          //         }
          //       default:
          //         return const Text('Waiting for verification...');
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
