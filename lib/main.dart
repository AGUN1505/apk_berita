import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita ',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Berita'),
        ),
        body: Center(
          child: Text('isi halaman'),
        ),
      ),
    );
  }
}
