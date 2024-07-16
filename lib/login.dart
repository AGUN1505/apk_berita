import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplikasi_berita/dashpage.dart';

class Login extends StatelessWidget {
  // const Login({super.key});
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();
  late String nUsername, nPassword;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                //cek data field jika kosong
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username Tidak Boleh Kosong";
                  }
                  return null;
                },
                controller: myUsernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                //cek data field jika kosong
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "password tidak boleh kosong";
                  }
                  return null;
                },
                maxLength: 16,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                obscureText: true,
                controller: myPasswordController,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 25.0),
              MaterialButton(
                  minWidth: 85.0,
                  height: 50.0,
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    //dapatkan value dari textformfield
                    nUsername = myUsernameController.text;
                    nPassword = myPasswordController.text;

                    if (_formkey.currentState!.validate()) {
                      if (nUsername != 'admin') {
                        print('username salah');
                      } else if (nPassword.length <= 5) {
                        print("pasword harus lebih dari 5 karakter");
                      } else
                        (
                            // aksi untuk menuju dashboard karena berhasil login
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) {
                          return DashPage(nama: nUsername, password: nPassword);
                        })));
                    }
                  },
                  child: Text('submit')),
            ],
          ),
        ),
      ),
    );
  }
}
