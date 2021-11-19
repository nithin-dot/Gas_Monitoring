// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:gas_monitoring/Apidata.dart';
void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
   const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}
 

  // This widget is the root of your application.
 
class _MainPageState extends State<MainPage> {
  var finalDate = '';
  late NodeMcu kdata;
  @override
  void initState() {
    super.initState();

    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);
    setState(() {
      finalDate = dateFormat.toString();
    });
  }

  Future<NodeMcu> getData() async {
    // var url = Uri.parse('http://10.10.168.24:4000');
    var url = Uri.parse('http://10.10.165.177:3000');
    http.Response res = await http.get(url);
    // var res = await http.get(Uri.http("http://192.168.0.95:3000", ""));
    print(res.body);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      kdata = NodeMcu.fromJson(data);
    }
    return kdata;
    // print("List Size: ${list.length}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: Colors.white,
            title: Text('Dashboard',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ),
          body: StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 1))
                  .asyncMap((i) => getData()),
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Center(child: CircularProgressIndicator())
                    : StaggeredGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 29.0),
                        children: <Widget>[
                          _buildTile(
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Text('Total Views',
                                        //     style: TextStyle(color: Colors.blueAccent)),

                                        Icon(CupertinoIcons.smoke_fill,
                                            color: Colors.blue, size: 30.0),

                                        Text(
                                            snapshot.data.gas > 400
                                                ? "Unusual"
                                                : "Usual",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 34.0))
                                      ],
                                    ),
                                    Material(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "S",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )))
                                  ]),
                            ), onTap: () {  },
                          ),
                          _buildTile(
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Material(
                                        color: Colors.red[400],
                                        shape: CircleBorder(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "T",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 16.0)),
                                    Row(
                                      children: [
                                        Text(
                                            snapshot.data.temperature
                                                    .toString() +
                                                '°C',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0)),
                                        Icon(Icons.thermostat_sharp,
                                            color: Colors.redAccent,
                                            size: 30.0),
                                      ],
                                    ),
                                  ]),
                            ), onTap: () {  },
                          ),
                          _buildTile(
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Material(
                                        color: Colors.orange[400],
                                        shape: CircleBorder(),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            "H",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 16.0)),
                                    Row(
                                      children: [
                                        Text(
                                            snapshot.data.humidity.toString() +
                                                '%',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0)),
                                        Icon(CupertinoIcons.drop,
                                            color: Colors.orange[200],
                                            size: 25.0),
                                      ],
                                    ),
                                  ]),
                            ), onTap: () {  },
                          ),
                          _buildTile(
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Material(
                                                color: Colors.blueGrey[200],
                                                shape: CircleBorder(),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                      CupertinoIcons
                                                          .umbrella_fill,
                                                      color: Colors.white,
                                                      size: 20.0),
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(finalDate,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24.0)),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                                snapshot.data.temperature
                                                        .toString() +
                                                    '°C',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20.0)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Column(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                Center(
                                                  child: Icon(
                                                      CupertinoIcons.cloud_sun,
                                                      color:
                                                          Colors.orangeAccent,
                                                      size: 70.0),
                                                ),
                                                Text('sun-rise',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20.0)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            onTap: () => {print("Done")},
                          )
                        ],
                        // ignore: prefer_const_literals_to_create_immutables
                        staggeredTiles: [
                          StaggeredTile.extent(5, 110.0),
                          StaggeredTile.extent(1, 180.0),
                          StaggeredTile.extent(1, 180.0),
                          StaggeredTile.extent(2, 200.0),
                        ],
                      );
              })),
    );
  }

  Widget _buildTile(Widget child, {required Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
