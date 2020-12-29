import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

void main() {
  runApp(CupertinoApp(home: MyApp()));
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
    // Can't show a dialog in initState, delaying initialization
    SchedulerBinding.instance.addPostFrameCallback((_) => initPlugin());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    TrackingStatus status;

    if (await AppTrackingTransparency.canRequestTrackingAuthorization()) {
      // Show a custom explainer dialog before the system dialog
      if (await showCustomTrackingDialog(context)) {
        // Wait for dialog popping animation
        await Future.delayed(const Duration(milliseconds: 200));
        // Platform messages may fail, so we use a try/catch PlatformException.
        try {
          status = await AppTrackingTransparency.requestTrackingAuthorization();
        } on PlatformException {
          _authStatus = 'Failed to open tracking auth dialog.';
        }
        setState(() {
          _authStatus = "$status";
        });
      }
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  Future<bool> showCustomTrackingDialog(BuildContext context) =>
      showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Explain Title'),
          content: const Text('Explain Description'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, false),
              child: SizedBox(
                // Force vertical layout
                width: MediaQuery.of(context).size.width / 2,
                child: const Text("I'll decide later"),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Allow tracking'),
            ),
          ],
        ),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('App Tracking Transparency Example'),
      ),
      child: Center(
        child: Text('Tracking status: $_authStatus\n'),
      ),
    );
  }
}
