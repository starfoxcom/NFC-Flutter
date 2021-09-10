import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Class component for a design action button.
///
/// This component class depends of the following package:
///
/// * `font_awesome_flutter`
///
/// consider adding it to your dependencies on the `pubspec.yaml`
/// file of the project.
class ActionButtonComponent extends StatelessWidget {
  /// The left padding of this component.
  final double leftPadding;

  /// The top padding of this component.
  final double topPadding;

  /// The right padding of this component.
  final double rightPadding;

  /// The bottom padding of this component.
  final double bottomPadding;

  /// The symmetric vertical padding of this component.
  ///
  /// This has priority over the [topPadding] and [bottomPadding] values.
  final double? verticalPadding;

  /// The symmetric horizontal padding of this component.
  ///
  /// This has proprity over the [leftPadding] and [rightPadding] values.
  final double? horizontalPadding;

  /// The spacing between the [prefixIcon], [labelText] and [suffixIcon] of this component.
  final double contentSpacing;

  /// The width of this component.
  final double? width;

  /// The height of this component.
  final double? height;

  /// The elevation of this component.
  final double? elevation;

  /// The text to display on this component.
  final String labelText;

  /// The text color of this component.
  final Color textColor;

  /// The text [onHover] color of this component.
  final Color hoverTextColor;

  /// The background color of this component.
  final Color backgroundColor;

  /// The highlight [onHover] color of this component.
  final Color hoverColor;

  /// The highlight [onPressed] color of this component. This also establishes
  /// the [borderColor] for the [onPressed] state.
  final Color highlightColor;

  /// The border color of this component.
  final Color borderColor;

  /// The border radius (circular) of this component.
  final double borderRadius;

  /// The border radius (circular) [onPressed] of this component. If null, the
  /// normal [borderRadius] is used instead.
  final double? pressedBorderRadius;

  /// The border width of this component.
  final double borderWidth;

  /// The border width [onPressed] of this component. If null, the normal
  /// [borderWidth] is used instead.
  final double? pressedBorderWidth;

  /// Sets the prefix icon visible of this component.
  final bool isPrefixIconVisible;

  /// Sets the suffix icon visible of this component.
  final bool isSuffixIconVisible;

  /// The prefix icon of this component.
  final IconData prefixIcon;

  /// The suffix icon of this component.
  final IconData suffixIcon;

  /// The icons size of this component.
  final double iconSize;

  /// The font size of this component.
  final double fontSize;

  /// The [onPressed] callback function of this component.
  final void Function() onPressedCallback;

  /// The [onLongPressed] callback function of this component.
  final void Function() onLongPressedCallback;

  const ActionButtonComponent({
    Key? key,
    this.leftPadding = 0,
    this.topPadding = 0,
    this.rightPadding = 0,
    this.bottomPadding = 0,
    this.verticalPadding,
    this.horizontalPadding,
    this.contentSpacing = 10,
    this.width,
    this.height,
    this.elevation = 0,
    this.labelText = "Label text",
    this.textColor = Colors.black,
    this.hoverTextColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.highlightColor = Colors.grey,
    this.hoverColor = Colors.black,
    this.borderColor = Colors.black,
    this.borderRadius = 0,
    this.borderWidth = 2,
    this.pressedBorderRadius,
    this.pressedBorderWidth,
    this.isPrefixIconVisible = false,
    this.isSuffixIconVisible = false,
    this.prefixIcon = FontAwesomeIcons.icons,
    this.suffixIcon = FontAwesomeIcons.icons,
    this.fontSize = 24,
    this.iconSize = 24,
    required this.onPressedCallback,
    required this.onLongPressedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPadding ?? leftPadding,
        top: verticalPadding ?? topPadding,
        right: horizontalPadding ?? rightPadding,
        bottom: verticalPadding ?? bottomPadding,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.hovered)
                    ? hoverTextColor
                    : textColor;
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.pressed)
                    ? hoverColor
                    : backgroundColor),
            overlayColor: MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.pressed)
                    ? highlightColor
                    : hoverColor;
              },
            ),
            elevation: MaterialStateProperty.all(elevation),
            shape: MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.pressed)
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          pressedBorderRadius ?? borderRadius,
                        ),
                        side: BorderSide(
                          width: pressedBorderWidth ?? borderWidth,
                          color: highlightColor,
                        ),
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        side: BorderSide(
                          width: borderWidth,
                          color: borderColor,
                        ),
                      );
              },
            ),
          ),
          onPressed: () {
            onPressedCallback();
          },
          onLongPress: () {
            onLongPressedCallback();
          },
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: contentSpacing,
            children: [
              (isPrefixIconVisible)
                  ? Icon(
                      prefixIcon,
                      size: iconSize,
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              Text(
                labelText,
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
              (isSuffixIconVisible)
                  ? Icon(
                      suffixIcon,
                      size: iconSize,
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
