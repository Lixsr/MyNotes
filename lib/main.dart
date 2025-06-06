import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';

// Views
import 'package:notes/view/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'My Notes',
      // Disable the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          // background color of the app bar
          backgroundColor: Colors.redAccent,
          // text color of the app bar
          foregroundColor: Colors.black,
        ),
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                return const Text("You are logged in.");
              } else {
                if (user?.emailVerified ?? false) {
                  print("Email is verified.");
                } else {
                  print("Email is not verified.");
                }
              }
              return const Text("Firebase initialized successfully.");
            default:
              return const Text(
                "Something went wrong, please try again later.",
              );
          }
        },
      ),
    );
  }
}
