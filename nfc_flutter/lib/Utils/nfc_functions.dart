import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfc_flutter/widgets/alertDialogComponent.dart';
import 'package:ndef/ndef.dart' as ndef;

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
      // Start Session
      var tag = await FlutterNfcKit.poll();

      // Read NFC Records
      for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
        print(Utf8Decoder().convert(record.payload!.toList()));
        tag = NFCTag(
            tag.type,
            tag.id,
            tag.standard,
            tag.atqa,
            tag.sak,
            tag.historicalBytes,
            tag.protocolInfo,
            record.decodedType == 'T'
                ? Utf8Decoder().convert(record.payload!.toList(), 3)
                : Utf8Decoder().convert(record.payload!.toList()),
            tag.hiLayerResponse,
            tag.manufacturer,
            tag.systemCode,
            tag.dsfId,
            tag.ndefAvailable,
            tag.ndefType,
            tag.ndefCapacity,
            tag.ndefWritable,
            tag.ndefCanMakeReadOnly);
      }

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

FutureOr writeNFC(BuildContext context, String data) async {
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

      await FlutterNfcKit.writeNDEFRecords(
          [ndef.TextRecord(text: data, language: 'en')]);

      tag = NFCTag(
          tag.type,
          tag.id,
          tag.standard,
          tag.atqa,
          tag.sak,
          tag.historicalBytes,
          tag.protocolInfo,
          data,
          tag.hiLayerResponse,
          tag.manufacturer,
          tag.systemCode,
          tag.dsfId,
          tag.ndefAvailable,
          tag.ndefType,
          tag.ndefCapacity,
          tag.ndefWritable,
          tag.ndefCanMakeReadOnly);

      // Start Session
      // Pop out awaiting dialog and pop in found tag dialog
      await FlutterNfcKit.finish();
      Navigator.of(context).pop(true);
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
