import 'package:flutter/material.dart';
import 'package:aplikasi_berita/homepage.dart';

class NewsDetail extends StatelessWidget {
  final Map news;
  const NewsDetail({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Detail Berita')),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.network(url2 + '/img/' + news['gambar']),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(news['judul'],
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(left: 25.0),
            child: Row(
              children: [Icon(Icons.facebook), Icon(Icons.tiktok)],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              news['isi'],
              style: TextStyle(fontSize: 11.0),
            ),
          )
        ],
      ),
    );
  }
}
