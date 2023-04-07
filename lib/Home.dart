import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override

  Future<dynamic> getData() async {
    var resp = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=34.5&lon=75.2&appid=499af8df690609d7b49851aba85cbcc4'));
    var body =jsonDecode(resp.body);
    var data = body['weather'];
    return
        data ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  if(snapshot.hasData) {
                    return
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(color: Colors.blueGrey[50]),
                                  child: Center(
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data[0]['id'].toString()),
                                        Text(snapshot.data[0]['main']),
                                        Text(snapshot.data[0]['description']),
                                        Text(snapshot.data[0]['icon'])
                                      ],
                                    ),
                                  ),
                                ),
                              );
                          },
                        ),
                      );
                  }
                  else{
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors
                            .blueGrey[50]),
                        child: const Center(
                          child: Text('No Data'),
                        ),
                      ),
                    );
                  }
                },
              ),
        ],
      ),
    );
  }
}
