import 'package:databasesqflite/notes.dart';
import 'package:databasesqflite/sql.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initilizeDatabse();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: pageone(),
      debugShowCheckedModeBanner: false,
    );
  }
}
