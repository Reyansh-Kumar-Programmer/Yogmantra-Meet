import 'package:flutter/material.dart';
import 'package:yogmantra_meet/resources/auth_methods.dart';
import 'package:yogmantra_meet/screens/home_screen.dart';
import 'package:yogmantra_meet/screens/login_screen.dart';
import 'package:yogmantra_meet/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yogmantra Meet 📽️',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      // This part is for the checking if the user is logged in if so go to the home page
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasData) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
      // This part is for the checking if the user is logged in if so go to the home page
    );
  }
}
