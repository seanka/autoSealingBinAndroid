import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'firstContainer.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayText = 'aaaa';
  final _database = FirebaseDatabase.instance.reference();
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription _readDatabase;
  @override
  void initState() {
    super.initState();
    _activeListeners();
  }

  void _activeListeners() {
    _database.child('/data').onValue.listen((event) {
      final int description = event.snapshot.value;
      setState(() {
        // description == 483? _displayText = "TRUE" : _displayText = "FALSE";
        _displayText = description.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              FirstContainer(),

              Text(_displayText, style: const TextStyle(fontSize: 50, color: Colors.black),),
              ElevatedButton(
                  onPressed: () async {
                    try{
                      await database.update({'/rgbString' : "10"});
                    }catch (e) {

                    }
                  },
                  child: const Text("update data",))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _readDatabase.cancel();
    super.deactivate();
  }
}
