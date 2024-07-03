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
          title: Center(child: const Text('Berita')),
        ),
        body: FutureBuilder(
            future: fetcNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Text(snapshot.data['data'][index]['judul']);
                  },
                );
              } else {
                return const Text('data eror');
              }
            }));
  }
}
