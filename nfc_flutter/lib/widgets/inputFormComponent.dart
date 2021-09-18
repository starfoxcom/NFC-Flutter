import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Class component for a input text form.
///
/// This component class depends of the following package:
///
/// * `font_awesome_flutter`
///
/// consider adding it to your dependencies on the `pubspec.yaml`
/// file of the project.
class InputFormComponent extends StatefulWidget {
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

  /// The width of this component.
  final double width;

  /// The height of this component.
  final double height;

  /// The text height of this component.
  final double? textHeight;

  /// The hint text of this component.
  final String? hintText;

  /// The label text of this component.
  final String? labelText;

  /// Sets to apply the background color of this component.
  final bool isBackgroundFilled;

  /// The background color of this component.
  final Color backgroundColor;

  /// Sets the border of this component.
  final bool isBorderEnabled;

  /// Sets the border to [OutlineInputBorder] or [UnderlineInputBorder] of this
  /// component.
  final bool isOutlineBorder;

  /// The enabled border color of this component.
  final Color enabledBorderColor;

  /// The enabled border width of this component.
  final double enabledBorderWidth;

  /// The enabled border color of this component.
  final Color focusedBorderColor;

  /// The enabled border width of this component.
  final double focusedBorderWidth;

  /// The enabled border color of this component.
  final Color errorBorderColor;

  /// The enabled border width of this component.
  final double errorBorderWidth;

  /// The enabled border color of this component.
  final Color focusedErrorBorderColor;

  /// The enabled border width of this component.
  final double focusedErrorBorderWidth;

  /// The border radius (circular) of this component.
  final double borderRadius;

  /// Sets the prefix icon visible of this component.
  final bool isPrefixIconVisible;

  /// The prefix icon of this component.
  final IconData prefixIcon;

  /// The prefix icon color of this component.
  final Color prefixIconColor;

  /// Sets the suffix icon visible of this component (ignored if [isObscureText] is true).
  final bool isSuffixIconVisible;

  /// The suffix icon of this component (when [isObscureText] is not true).
  final IconData suffixIcon;

  /// The suffix icon color of this component.
  final Color suffixIconColor;

  /// The prefix icon size of this component.
  final double prefixIconSize;

  /// The suffix icon size of this component.
  final double suffixIconSize;

  /// Sets the obscure text of this component.
  final bool isObscureText;

  /// The font size of this component.
  final double fontSize;

  /// The error font size of this component.
  final double errorFontSize;

  /// The text color of this component.
  final Color textColor;

  /// The input type to optimize the input control of this component.
  final TextInputType? inputType;

  /// The input action from the input control of this component.
  final TextInputAction? inputAction;

  /// The text editing controller of this component.
  final TextEditingController textController;

  /// Sets the validator requirement of this component.
  final bool requireValidation;

  /// The [validator] callback function of this component.
  final String? Function(String)? customValidatorCallback;

  /// The default empty input validator message of this component.
  final String? isEmptyValidatorText;

  /// The [onChanged] callback function of this component.
  final void Function(String)? onChangedCallback;

  /// The [onEditingComplete] callback function of this component.
  final void Function()? onEditingComplete;

  /// The [onFieldSubmitted] callback function of this component.
  final void Function(String)? onFieldSubmittedCallback;

  /// The max text length of this component.
  final int? maxLength;

  /// The [onPressed] callback function for the suffix icon of this component.
  final void Function()? onSuffixIconPressed;
  const InputFormComponent({
    Key? key,
    this.leftPadding = 0,
    this.topPadding = 0,
    this.rightPadding = 0,
    this.bottomPadding = 0,
    this.verticalPadding,
    this.horizontalPadding,
    this.width = 100,
    this.height = 100,
    this.textHeight,
    this.hintText,
    this.labelText,
    this.isBackgroundFilled = true,
    this.backgroundColor = Colors.grey,
    this.isBorderEnabled = true,
    this.isOutlineBorder = true,
    this.enabledBorderColor = Colors.white,
    this.enabledBorderWidth = 1,
    this.focusedBorderColor = Colors.white,
    this.focusedBorderWidth = 2,
    this.errorBorderColor = Colors.red,
    this.errorBorderWidth = 1,
    this.focusedErrorBorderColor = Colors.red,
    this.focusedErrorBorderWidth = 2,
    this.borderRadius = 0,
    this.isPrefixIconVisible = true,
    this.prefixIcon = FontAwesomeIcons.icons,
    this.prefixIconColor = Colors.white,
    this.isSuffixIconVisible = true,
    this.suffixIcon = FontAwesomeIcons.icons,
    this.suffixIconColor = Colors.white,
    this.prefixIconSize = 24,
    this.suffixIconSize = 24,
    this.isObscureText = false,
    this.fontSize = 24,
    this.errorFontSize = 18,
    this.textColor = Colors.white,
    this.inputType,
    this.inputAction,
    required this.textController,
    this.requireValidation = false,
    this.customValidatorCallback,
    this.isEmptyValidatorText = 'Required field',
    this.onChangedCallback,
    this.onEditingComplete,
    this.onFieldSubmittedCallback,
    this.onSuffixIconPressed,
    this.maxLength,
  }) : super(key: key);
  @override
  _InputFormComponentState createState() => _InputFormComponentState();
}

class _InputFormComponentState extends State<InputFormComponent> {
  bool obscureText = true;

  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.horizontalPadding ?? widget.leftPadding,
        top: widget.verticalPadding ?? widget.topPadding,
        right: widget.horizontalPadding ?? widget.rightPadding,
        bottom: widget.verticalPadding ?? widget.bottomPadding,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: widget.width,
          maxHeight: widget.height,
        ),
        child: Center(
          child: TextFormField(
            controller: widget.textController,
            decoration: InputDecoration(
              isDense: true,
              filled: widget.isBackgroundFilled,
              fillColor: widget.backgroundColor,
              enabledBorder: (widget.isBorderEnabled)
                  ? (widget.isOutlineBorder)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.enabledBorderColor,
                              width: widget.enabledBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.enabledBorderColor,
                              width: widget.enabledBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                  : OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(widget.borderRadius)),
              focusedBorder: (widget.isBorderEnabled)
                  ? (widget.isOutlineBorder)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.focusedBorderColor,
                              width: widget.focusedBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.focusedBorderColor,
                              width: widget.focusedBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                  : OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(widget.borderRadius)),
              errorBorder: (widget.isBorderEnabled)
                  ? (widget.isOutlineBorder)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.errorBorderColor,
                              width: widget.errorBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.errorBorderColor,
                              width: widget.errorBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                  : OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(widget.borderRadius)),
              focusedErrorBorder: (widget.isBorderEnabled)
                  ? (widget.isOutlineBorder)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.focusedErrorBorderColor,
                              width: widget.focusedErrorBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: widget.focusedErrorBorderColor,
                              width: widget.focusedErrorBorderWidth),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))
                  : OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(widget.borderRadius)),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (widget.isPrefixIconVisible) ? 20.0 : 0,
                ),
                child: Icon(
                  (widget.isPrefixIconVisible) ? widget.prefixIcon : null,
                  size: widget.prefixIconSize,
                  color: widget.prefixIconColor,
                ),
              ),
              suffixIcon: (widget.isObscureText)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: IconButton(
                        icon: (obscureText)
                            ? Icon(FontAwesomeIcons.solidEyeSlash,
                                color: widget.suffixIconColor)
                            : Icon(FontAwesomeIcons.solidEye,
                                color: widget.suffixIconColor),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: (widget.isSuffixIconVisible) ? 20.0 : 0,
                      ),
                      child: (widget.onSuffixIconPressed != null)
                          ? IconButton(
                              icon: (widget.isSuffixIconVisible)
                                  ? Icon(
                                      widget.suffixIcon,
                                      color: widget.suffixIconColor,
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                              iconSize: widget.suffixIconSize,
                              onPressed: widget.onSuffixIconPressed,
                            )
                          : Icon(
                              (widget.isSuffixIconVisible)
                                  ? widget.suffixIcon
                                  : null,
                              size: widget.suffixIconSize,
                              color: widget.suffixIconColor,
                            ),
                    ),
              errorStyle: TextStyle(fontSize: widget.errorFontSize),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.textColor.withOpacity(0.5)),
              helperText: '',
              labelText: widget.labelText,
              labelStyle: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.textColor.withOpacity(0.5)),
            ),
            validator: (value) {
              if (widget.requireValidation) {
                if (value!.isEmpty) {
                  return widget.isEmptyValidatorText;
                }
                return widget.customValidatorCallback!(value);
              }
              return null;
            },
            obscureText: (widget.isObscureText) ? obscureText : false,
            style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.textColor,
                height: widget.textHeight),
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
            onChanged: widget.onChangedCallback,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmittedCallback,
            maxLength: widget.maxLength,
          ),
        ),
      ),
    );
  }
}
