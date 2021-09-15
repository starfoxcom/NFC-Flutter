import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfc_flutter/Utils/nfc_functions.dart';
import 'package:nfc_flutter/widgets/actionButtonComponent.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

Widget? nfcInfo = Container();

class _HomeViewState extends State<HomeView> {
  NFCTag? tag;
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
                onPressedCallback: () async {
                  setState(() {
                    tag = null;
                  });
                  var result = await readNFC(context);
                  setState(() {
                    tag = result;
                  });
                },
                onLongPressedCallback: () {}),
            // TODO Write NFC Tag button
            Text(
              'Write NFC Tag (WIP)',
            ),
            // Tag data
            TagData(tag: tag),
          ],
        ),
      ),
    );
  }
}

class TagData extends StatelessWidget {
  const TagData({
    Key? key,
    required this.tag,
  }) : super(key: key);

  final NFCTag? tag;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.decelerate,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation =
            Tween<Offset>(begin: Offset(0.0, 5.0), end: Offset(0.0, 0.0))
                .animate(animation);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      duration: Duration(
        seconds: 1,
      ),
      child: tag == null
          ? nfcInfo
          : Card(
              child: Column(
                children: [
                  Text(
                    'Identifier',
                    textScaleFactor: 2,
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Text(
                    '${tag?.id}',
                    textScaleFactor: 1.5,
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    'Data',
                    textScaleFactor: 2,
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Text(
                    '${tag?.applicationData}',
                    textScaleFactor: 1.5,
                  ),
                ],
              ),
            ),
    );
  }
}
