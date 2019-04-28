import 'dart:async' as prefix0;

import 'package:flutter/material.dart';
import 'dart:async';
import 'movies.dart' as MovieHandler;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Movie Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Write a handler for results on overlay
  MovieHandler.Movie _movies = new MovieHandler.Movie();
  Stream<List<Map<String,dynamic>>> _queryEvent;

  Stream<List<Map<String,dynamic>>> _queryStream(String _query){
    _queryEvent = _movies.findMyMovie(_query).asStream();
    return _queryEvent;
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new SafeArea(
        child: new Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: new StreamBuilder(
                  stream: _queryEvent,
                  builder: (context, data){
                    if (data.data == null) {
                      return new Text("No data.");
                    } else {
                      return new ListView.builder(
                        itemCount: data.data.count,
                        itemBuilder: (context, int index){
                          return new Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("${data.data['results'][index]}"),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      color: Colors.white,
                      child: TextField(
                        decoration: new InputDecoration(
                            icon: Icon(Icons.search),
                            labelText: "Search for Movies."),
                        obscureText: false,
                        onChanged: (setQuery) {
                          // pass setQuery to movieAPI handler
                          _queryStream(setQuery);
                        },
                      )),
                ]),
          ],
        ),
      ),
    );
  }
}
