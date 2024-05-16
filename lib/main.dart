import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trackcase/screens/welcom_screen.dart'; // Import correct
import 'package:trackcase/firebase_options.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.android);
  print(  FirebaseAuth.instance.currentUser?.displayName ?? 'Guest');


  runApp(const MyApp()); // Removed 'const' keyword
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Added 'Key?' to constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple), // Changed 'fromSeed' to 'fromSwatch' and 'seedColor' to 'primarySwatch'
        // useMaterial3: true, // Removed this line as it's not a valid property in ThemeData
      ),
      home: const WelcomeScreen(),
    );
  }
}
