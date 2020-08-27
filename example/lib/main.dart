import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _authStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    TrackingStatus status;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    } on PlatformException {
      _authStatus = 'Failed to open tracking auth dialog.';
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");

    if (!mounted) {
      return;
    }

    setState(() {
      _authStatus = "$status";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Tracking Transparency Example'),
        ),
        body: Center(
          child: Text('Tracking status: $_authStatus\n'),
        ),
      ),
    );
  }
}
