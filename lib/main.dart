import 'package:flutter/material.dart';
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
      title: 'İlaydaÜmit',
      home: Scaffold(
        appBar: AppBar(title: Text('İlaydaÜmit')),
        body: Center(child: Text('💖 Uygulama hazır 💖')),
      ),
    );
  }
}