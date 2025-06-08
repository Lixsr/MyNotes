import 'package:flutter/material.dart';
// Firebase imports
import 'package:firebase_auth/firebase_auth.dart';


// Stateless needs to be restarted to apply changes
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
                  .signInWithEmailAndPassword(email: email, password: password);
              print("User signed in: ${userCredentials.user?.email}");
            } on FirebaseAuthException catch (e) {
              print("Error signing in: ${e.code}");
            } catch (e) {
              print("Error signing in: $e");
            }
          },
          child: const Text("Sign in"),
        ),
      ],
    );
  }
}
