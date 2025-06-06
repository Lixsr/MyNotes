import 'package:flutter/material.dart';

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
      home: const LoginView(),
    ),
  );
}


