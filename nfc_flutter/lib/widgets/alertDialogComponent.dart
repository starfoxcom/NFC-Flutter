import 'dart:async';

import 'package:flutter/material.dart';

import 'actionButtonComponent.dart';

/// Class component for an alert dialog.
///
/// This component class depends on the [actionButtonComponent], make sure
/// that you have the component on your project added.
class AlertDialogComponent extends StatefulWidget {
  /// The background color of this component.
  final Color backgroundColor;

  /// The border color of this component.
  final Color borderColor;

  /// The border width of this component.
  final double borderWidth;

  /// The border radius of this component.
  final double borderRadius;

  /// The title text to display on this component.
  final String titleText;

  /// The title size of this component.
  final double titleSize;

  /// The title color of this component.
  final Color titleColor;

  /// The horizontal padding (for content width) of this component.
  final double horizontalPadding;

  /// Sets the simple description of this component.
  ///
  /// If set to [true], then only a [Text] with a description string will be
  /// shown, otherwise a [widget] as description is required.
  final bool isSimpleDescription;

  /// The custom widget description of this component.
  final Widget? customDescription;

  /// The description text to display on this component.
  final String descriptionText;

  /// The description size of this component.
  final double descriptionSize;

  /// The description color of this component.
  final Color descriptionColor;

  /// Sets the single button of this component.
  ///
  /// If set to [true], then only [onOkCallback] cannot be null, otherwise
  /// [onCancelCallback] cannot be null too.
  final bool isSingleButton;

  /// The cancel button width of this component.
  final double? cancelButtonWidth;

  /// The cancel button border radius of this component.
  final double cancelButtonBorderRadius;

  /// The cancel button border color of this component.
  final Color cancelButtonBorderColor;

  /// The cancel button hover color of this component.
  final Color cancelButtonHoverColor;

  /// The cancel button highlight color of this component.
  final Color cancelButtonHighlightColor;

  /// The cancel button background color of this component.
  final Color cancelButtonBackgroundColor;

  /// The cancel button text color of this component.
  final Color cancelButtonTextColor;

  /// The cancel button text to display on this component.
  final String cancelButtonText;

  /// The cancel button [onPressedCallback] callback function of this component.
  final void Function() onCancelCallback;

  /// The ok button width of this component.
  final double? okButtonWidth;

  /// The ok button border radius of this component.
  final double okButtonBorderRadius;

  /// The ok button border color of this component.
  final Color okButtonBorderColor;

  /// The ok button background color of this component.
  final Color okButtonBackgroundColor;

  /// The ok button hover color of this component.
  final Color okButtonHoverColor;

  /// The ok button highlight color of this component.
  final Color okButtonHighlightColor;

  /// The ok button text color of this component.
  final Color okButtonTextColor;

  /// The ok button text to display on this component.
  final String okButtonText;

  /// Sets the timer to activate buttons of this component.
  ///
  /// If set to [true], then [timerDuration] cannot be null.
  final bool isTimerActive;

  /// The duration fo the timer to activate buttons of this component.
  final int timerDuration;

  /// The ok button [onPressedCallback] callback function of this component.
  final void Function() onOkCallback;

  const AlertDialogComponent({
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 2,
    this.borderRadius = 10,
    this.titleText = 'title text',
    this.titleSize = 20,
    this.titleColor = Colors.black,
    this.horizontalPadding = 0,
    this.isSimpleDescription = true,
    this.customDescription,
    this.descriptionText = 'description text',
    this.descriptionSize = 20,
    this.descriptionColor = Colors.black,
    this.isSingleButton = false,
    this.cancelButtonWidth,
    this.cancelButtonBorderRadius = 0,
    this.cancelButtonBorderColor = Colors.blueAccent,
    this.cancelButtonBackgroundColor = Colors.white,
    this.cancelButtonHighlightColor = Colors.grey,
    this.cancelButtonHoverColor = Colors.white,
    this.cancelButtonTextColor = Colors.black,
    this.cancelButtonText = 'Cancel',
    required this.onCancelCallback,
    this.okButtonWidth,
    this.okButtonBorderRadius = 0,
    this.okButtonBorderColor = Colors.blueAccent,
    this.okButtonBackgroundColor = Colors.white,
    this.okButtonHighlightColor = Colors.grey,
    this.okButtonHoverColor = Colors.white,
    this.okButtonTextColor = Colors.black,
    this.okButtonText = 'Ok',
    required this.onOkCallback,
    this.isTimerActive = false,
    Key? key,
    this.timerDuration = 3,
  }) : super(key: key);

  @override
  _AlertDialogComponentState createState() => _AlertDialogComponentState();
}

class _AlertDialogComponentState extends State<AlertDialogComponent> {
  /// If buttons are active
  bool activeButtons = true;
  int countTime = 0;

  /// Start the countdown to activate buttons
  void startCountDownTimer() {
    countTime = 0;
    if (widget.isTimerActive == true) {
      activeButtons = false;
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (countTime < widget.timerDuration)
          countTime++;
        else {
          activeButtons = true;
          timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    startCountDownTimer();
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: widget.backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        title: Text(
          widget.titleText,
          style: TextStyle(
            fontSize: widget.titleSize,
            color: widget.titleColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 15,
                left: widget.horizontalPadding,
                right: widget.horizontalPadding,
              ),
              child: StatefulBuilder(
                builder: (context, setState) {
                  Timer.periodic(Duration(seconds: 1), (timer) {
                    if (activeButtons) timer.cancel();
                    if (mounted) setState(() {});
                  });
                  return Column(
                    children: [
                      widget.isSimpleDescription
                          ? Text(
                              widget.descriptionText,
                              style: TextStyle(
                                fontSize: widget.descriptionSize,
                                color: widget.descriptionColor,
                              ),
                            )
                          : widget.customDescription ??
                              Text(
                                'Missing custom description',
                                style: TextStyle(
                                  fontSize: widget.descriptionSize,
                                  color: widget.descriptionColor,
                                ),
                              ),
                      if (!activeButtons)
                        Text(
                          "Available in ${widget.timerDuration - countTime}",
                          style: TextStyle(
                            color: Color(0xFFB5a689),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            (widget.isSingleButton)
                ? ActionButtonComponent(
                    highlightColor: widget.okButtonHighlightColor,
                    hoverColor: widget.okButtonHoverColor,
                    width: widget.okButtonWidth,
                    borderRadius: widget.okButtonBorderRadius,
                    borderColor: widget.okButtonBorderColor,
                    backgroundColor: widget.okButtonBackgroundColor,
                    textColor: widget.okButtonTextColor,
                    labelText: widget.okButtonText,
                    onPressedCallback: () {
                      if (activeButtons) widget.onOkCallback();
                    },
                    onLongPressedCallback: () {},
                  )
                : Wrap(
                    spacing: 10,
                    children: [
                      ActionButtonComponent(
                        highlightColor: widget.cancelButtonHighlightColor,
                        hoverColor: widget.cancelButtonHoverColor,
                        width: widget.cancelButtonWidth,
                        borderRadius: widget.cancelButtonBorderRadius,
                        borderColor: widget.cancelButtonBorderColor,
                        backgroundColor: widget.cancelButtonBackgroundColor,
                        textColor: widget.cancelButtonTextColor,
                        labelText: widget.cancelButtonText,
                        onPressedCallback: () {
                          if (activeButtons) widget.onCancelCallback();
                        },
                        onLongPressedCallback: () {},
                      ),
                      ActionButtonComponent(
                        highlightColor: widget.okButtonHighlightColor,
                        hoverColor: widget.okButtonHoverColor,
                        width: widget.okButtonWidth,
                        borderRadius: widget.okButtonBorderRadius,
                        borderColor: widget.okButtonBorderColor,
                        backgroundColor: widget.okButtonBackgroundColor,
                        textColor: widget.okButtonTextColor,
                        labelText: widget.okButtonText,
                        onPressedCallback: () {
                          if (activeButtons) widget.onOkCallback();
                        },
                        onLongPressedCallback: () {},
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
