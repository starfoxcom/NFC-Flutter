import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nfc_flutter/Utils/nfc_functions.dart';
import 'package:nfc_flutter/widgets/actionButtonComponent.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Read NFC Tag button
            ActionButtonComponent(
                elevation: 5,
                labelText: 'Read NFC Tag',
                borderRadius: 10,
                highlightColor: Colors.grey.shade300,
                hoverColor: Colors.white,
                onPressedCallback: () {
                  readNFC(context);
                },
                onLongPressedCallback: () {}),
            Text(
              'Write NFC Tag (WIP)',
            ),
          ],
        ),
      ),
    );
  }
}
