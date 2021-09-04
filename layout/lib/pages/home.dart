import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appication Computer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
            // var data = json.decode(snapshot.data.toString());
            return ListView.builder(
                itemBuilder: (context, int index) {
                  return Mybox(
                      snapshot.data[index]['title'],
                      snapshot.data[index]['subtitle'],
                      snapshot.data[index]['image_url'],
                      snapshot.data[index]['detail']);
                },
                itemCount: snapshot.data.length);
          },
          // future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          future: getData(),
        ),
      ),
    );
  }

  Widget Mybox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      // color: Colors.blue[200],
      height: 150,
      decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.50), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          TextButton(
              onPressed: () {
                print("Next Page >>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              },
              child: Text("READ >"))
        ],
      ),
    );
  }

  Future getData() async {
    var url = Uri.https(
        'raw.githubusercontent.com', '/bundithdevER/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
