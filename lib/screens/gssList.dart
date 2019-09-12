import 'package:flutter/material.dart';
import 'dart:developer';

abstract class GssList extends StatefulWidget {
  GssList({Key key, this.title,}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  int getListLength();
  Widget getListItemWidget(int index);
  String getTitle();

  @override
  _GssListState createState() => _GssListState();
}

class _GssListState extends State<GssList> {

  void logg() {
    log("asd");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 8),
              child: Text(widget.getTitle(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.getListLength(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        color: Colors.blue[300],
                        child: Center(child: widget.getListItemWidget(index)),
                      ),
                      onTap: () => Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(index.toString()))),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: logg,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
