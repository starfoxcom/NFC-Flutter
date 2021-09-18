import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfc_flutter/Utils/nfc_functions.dart';
import 'package:nfc_flutter/widgets/actionButtonComponent.dart';
import 'package:nfc_flutter/widgets/inputFormComponent.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

Widget? nfcInfo = Container();

class _HomeViewState extends State<HomeView> {
  TextEditingController nfcDataTextController = TextEditingController();
  bool _writeNFC = false;
  NFCTag? tag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('NFC Flutter'),
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
            // Write NFC Tag button
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              switchInCurve: Curves.bounceInOut,
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(child: child, scale: animation),
              child: _writeNFC == false
                  ? ActionButtonComponent(
                      elevation: 5,
                      labelText: 'Write NFC Tag',
                      borderRadius: 10,
                      highlightColor: Colors.grey.shade300,
                      hoverColor: Colors.white,
                      onPressedCallback: () {
                        nfcDataTextController = TextEditingController();
                        setState(() {
                          _writeNFC = true;
                        });
                      },
                      onLongPressedCallback: () {})
                  : Card(
                      child: Column(
                        children: [
                          InputFormComponent(
                            textController: nfcDataTextController,
                            width: 500,
                            horizontalPadding: 25,
                            backgroundColor: Colors.white,
                            enabledBorderColor: Colors.black,
                            focusedBorderColor: Colors.black,
                            borderRadius: 10,
                            labelText: 'Data',
                            textColor: Colors.black,
                            isPrefixIconVisible: false,
                            suffixIcon: Icons.clear,
                            suffixIconColor: Colors.black,
                            onSuffixIconPressed: () {
                              nfcDataTextController.clear();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ActionButtonComponent(
                                  labelText: 'Cancel',
                                  borderRadius: 10,
                                  highlightColor: Colors.grey.shade300,
                                  hoverColor: Colors.white,
                                  onPressedCallback: () {
                                    setState(() {
                                      _writeNFC = false;
                                    });
                                  },
                                  onLongPressedCallback: () {}),
                              ActionButtonComponent(
                                  labelText: 'Write NFC Tag',
                                  borderRadius: 10,
                                  highlightColor: Colors.grey.shade300,
                                  hoverColor: Colors.white,
                                  onPressedCallback: () async {
                                    var result = await writeNFC(
                                        context, nfcDataTextController.text);
                                    setState(() {
                                      tag = result;
                                    });
                                  },
                                  onLongPressedCallback: () {})
                            ],
                          ),
                        ],
                      ),
                    ),
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
      switchInCurve: Curves.bounceInOut,
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
