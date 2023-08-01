import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              final email = _email.text;
              final password = _password.text;
              final userCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
              print(userCredential);
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: const Text('Return to Login'),
          )
        ],
      ),
    );
  }
}
