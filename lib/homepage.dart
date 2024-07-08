import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as link;

const url = "http://localhost:8080/api/";
const url2 = "http://localhost:8080/";

Future fetcNews() async {
  final response = await link.get(Uri.parse(url));
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.list),
          title: Center(child: const Text('Berita')),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.login),
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
                    // return Text(snapshot.data['data'][index]['judul']);
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
                                      child: Text(
                                          snapshot.data['data'][index]['judul'],
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]['isi'],
                                        maxLines: 5,
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                    ),
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
            }));
  }
}
