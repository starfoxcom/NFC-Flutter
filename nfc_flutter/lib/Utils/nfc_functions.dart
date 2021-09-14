import 'package:flutter/material.dart';
import 'package:nfc_flutter/widgets/alertDialogComponent.dart';
import 'package:nfc_manager/nfc_manager.dart';

Future<bool> readNFC(BuildContext context) async {
  // Check availability
  bool isAvailable = await NfcManager.instance.isAvailable();
  // On NFC functionality available or active
  if (isAvailable) {
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
              onOkCallback: () {
                NfcManager.instance.stopSession();
                Navigator.of(context).pop(true);
              },
            ));
    // Start Session
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        // Do something with an NfcTag instance.
        Ndef? ndef = Ndef.from(tag);
        String hexTag = '';
        for (int item in ndef?.additionalData.values.first) {
          hexTag += item.toRadixString(16).padLeft(2, '0').toUpperCase();
        }
        print(hexTag);
        print(ndef?.cachedMessage);
        if (ndef == null) {
          print('Tag is not compatible with NDEF');
          // Stop Session
          NfcManager.instance.stopSession();
          return;
        }
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
                  descriptionText: 'NFC Tag found',
                  okButtonText: 'Ok',
                  onCancelCallback: () => null,
                  onOkCallback: () {
                    Navigator.of(context).pop(true);
                  },
                ));
        // Stop Session
        NfcManager.instance.stopSession();
        return;
      },
    );
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
              descriptionText: 'NFC is not available or disabled',
              okButtonText: 'Ok',
              onCancelCallback: () => null,
              onOkCallback: () {
                Navigator.of(context).pop(true);
              },
            ));
    return false;
  }
  return true;
}

Future<bool> writeNFC(BuildContext context, String data) async {
  return false;
}
