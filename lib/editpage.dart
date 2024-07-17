import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aplikasi_berita/homepage.dart';
import 'package:aplikasi_berita/dashpage.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final String nama;
  final String password;
  final String id;
  const EditPage(
      {super.key,
      required this.nama,
      required this.password,
      required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formkey = GlobalKey<FormState>();

  //inisialisasi field
  var judulController = TextEditingController();
  var isiController = TextEditingController();
  var gambarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(url + "/${widget.id}"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          judulController = TextEditingController(text: data['judul']);
          isiController = TextEditingController(text: data['isi']);
          gambarController = TextEditingController(text: data['gambar']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _OnUpdate() async {
    try {
      return await http.put(Uri.parse(url + "/${widget.id}"), body: {
        "id": widget.id,
        "judul": judulController.text,
        "isi": isiController.text,
        "gambar": gambarController.text
      }).then((value) {
        var data = jsonDecode(value.body);
        print(data["messege"]);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DashPage(nama: widget.nama, password: widget.password),
            ));
      });
    } catch (e) {
      print(e);
    }
  }

  Future _onDelete() async {
    try {
      return await http.delete(Uri.parse(url + "/${widget.id}"), body: {
        "id": widget.id,
      }).then((value) {
        var data = jsonDecode(value.body);
        print(data["messege"]);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DashPage(nama: widget.nama, password: widget.password),
            ));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ubah berita'),
        actions: [
          Container(
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("apakah ingin menghapus?"),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Icon(Icons.cancel)),
                            ElevatedButton(
                                onPressed: () => _onDelete(),
                                child: Icon(Icons.check_circle))
                          ],
                        );
                      });
                },
                icon: Icon(Icons.delete)),
          )
        ],
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
                      _OnUpdate();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
