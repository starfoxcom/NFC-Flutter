import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfc_flutter/widgets/alertDialogComponent.dart';

FutureOr readNFC(BuildContext context) async {
  // Check availability
  var isAvailable = await FlutterNfcKit.nfcAvailability;

  // On NFC functionality available or active
  if (isAvailable == NFCAvailability.available) {
    // Pop in awaiting for NFC tag dialog
    showDialog(
        context: context,
        builder: (context) => AlertDialogComponent(
              isSingleButton: true,
              // okButtonBorderColor: Colors.transparent,
              okButtonHighlightColor: Colors.grey.shade300,
              okButtonBorderRadius: 10,
              borderColor: Colors.transparent,
              titleText: 'NFC',
              descriptionText: 'Awaiting for NFC Tag',
              okButtonText: 'Cancel',
              onCancelCallback: () => null,
              onOkCallback: () async {
                await FlutterNfcKit.finish();
                Navigator.of(context).pop(true);
              },
            ));
    try {
      var tag = await FlutterNfcKit.poll();

      // Start Session
      // Pop out awaiting dialog and pop in found tag dialog
      Navigator.of(context).pop(true);
      await FlutterNfcKit.finish();
      return tag;
    } catch (e) {
      // Pop out awaiting dialog and pop in found tag dialog
      Navigator.of(context).pop(true);
      showDialog(
          context: context,
          builder: (context) => AlertDialogComponent(
                isSingleButton: true,
                // okButtonBorderColor: Colors.transparent,
                okButtonHighlightColor: Colors.grey.shade300,
                okButtonBorderRadius: 10,
                borderColor: Colors.transparent,
                titleText: 'NFC',
                descriptionText: 'NFC Tag not found (timeout)',
                okButtonText: 'Ok',
                onCancelCallback: () => null,
                onOkCallback: () {
                  Navigator.of(context).pop(true);
                },
              ));
      return null;
    }
  } else {
    // Pop in NFC disabled dialog
    showDialog(
        context: context,
        builder: (context) => AlertDialogComponent(
              isSingleButton: true,
              okButtonHighlightColor: Colors.grey.shade300,
              okButtonBorderRadius: 10,
              borderColor: Colors.transparent,
              titleText: 'NFC',
              descriptionText: 'NFC is not supported or disabled',
              okButtonText: 'Ok',
              onCancelCallback: () => null,
              onOkCallback: () {
                Navigator.of(context).pop(true);
              },
            ));
    return null;
  }
}

Future<bool> writeNFC(BuildContext context, String data) async {
  return false;
}
