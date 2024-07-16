import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aplikasi_berita/homepage.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final judulController = TextEditingController();
  final isiController = TextEditingController();
  final gambarController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future _OnSubmit() async {
    try {
      return await http.post(Uri.parse(url), body: {
        "judul": judulController.text,
        "isi": isiController.text,
        "gambar": gambarController.text
      }).then((value) {
        var data = jsonDecode(value.body);
        print(data["messege"]);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah berita'),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'judul',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: judulController,
                decoration: InputDecoration(
                  hintText: 'Judul',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Judul Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              //
              Text(
                'isi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: isiController,
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'isi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "isi Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              //
              Text(
                'Gambar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: gambarController,
                decoration: InputDecoration(
                  hintText: 'Gambar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Gambar Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    //validasi
                    if (_formkey.currentState!.validate()) {
                      _OnSubmit();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
