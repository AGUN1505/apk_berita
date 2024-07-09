import 'package:flutter/material.dart';

class DashPage extends StatefulWidget {
  final String nama;
  final String password;
  const DashPage({super.key, required this.nama, required this.password});

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dashboard')),
      ),
      body: ListView(
        children: <Widget>[
          Text('nama : ${widget.nama}'),
          Text('password : ${widget.password}'),
        ],
      ),
    );
  }
}
