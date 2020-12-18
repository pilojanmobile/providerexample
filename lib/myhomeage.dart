import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/counterprovider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //Every Sec running this code ,but Consumer widget only Rebuild not all.
    //if you are define provider outside the
    //build method you need to specify "listen: false"
    Timer.periodic(Duration(seconds: 1), (timer) {
      final notifiprovider =
          Provider.of<CounterProvider>(context, listen: false);
      notifiprovider.callapi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child:
              Consumer<CounterProvider>(builder: (context, data, widget) {
            return data != null
                ? ListView.builder(
                    itemCount: data.result.length,
                    itemBuilder: (context, index) {
                      // print(data.result.length.toString());
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data.result[index]['title']),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          })),
          //button click then call api
          Center(child: Buttonwidget())
        ],
      ),
    );
  }
}

class Buttonwidget extends StatelessWidget {
  const Buttonwidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterProvider counterProvider =
        Provider.of<CounterProvider>(context);
    return Container(
      child: Center(
        child: RaisedButton.icon(
            onPressed: () {
              counterProvider.callapi();
            },
            icon: Icon(Icons.add),
            label: Text("Add")),
      ),
    );
  }
}
