import 'package:flutter/material.dart';

// Firebase imports
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // late: promises the variable will be initialized before being used. (trust me flutter).
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
    return Column(
      children: [
        TextField(
          controller: _email,
          decoration: const InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
          ),
        ),
        TextField(
          controller: _password,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
          ),
          obscureText: true, // Hides the password input
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              final userCredentials = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
              print("User created: ${userCredentials.user?.email}");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              } else {
                print('Error: ${e.code}');
              }
            } catch (e) {
              print('Error: $e');
            }
          },
          child: const Text("Sign up"),
        ),
      ],
    );
  }
}
