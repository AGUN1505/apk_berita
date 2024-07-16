import 'package:flutter/material.dart';
import 'package:aplikasi_berita/homepage.dart';
import 'package:aplikasi_berita/newsdetail.dart';
import 'package:aplikasi_berita/createpage.dart';

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
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatePage()));
            }),
        appBar: AppBar(
          leading: Icon(Icons.list),
          title: Center(child: Text('Dashboard')),
          actions: [
            GestureDetector(
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: ((context) => Login())));
              // },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(Icons.logout),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: fetcNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180,
                      child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                padding: EdgeInsets.all(10),
                                child: Image.network(url2 +
                                    '/img/' +
                                    snapshot.data['data'][index]['gambar']),
                              ),
                              Expanded(
                                  child: Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NewsDetail(
                                                  news: snapshot.data['data']
                                                      [index]),
                                            ),
                                          );
                                        },
                                        child: Text(
                                            snapshot.data['data'][index]
                                                ['judul'],
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]['isi'],
                                        maxLines: 5,
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                    ),
                                    Row(children: [
                                      Icon(Icons.edit),
                                      Icon(Icons.delete),
                                    ])
                                  ],
                                ),
                              ))
                            ],
                          )),
                    );
                  },
                );
              } else {
                return const Text('data eror');
              }
            })
        // ListView(
        //   children: <Widget>[
        //     Text('nama : ${widget.nama}'),
        //     Text('password : ${widget.password}'),
        //   ],
        // ),
        );
  }
}
