import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core.dart';

/// Pin code text fields which automatically changes focus and validates
class OtpTextInput extends StatefulWidget {
  OtpTextInput({
    super.key,
    required this.length,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.blinkWhenObscuring = false,
    this.blinkDuration = const Duration(milliseconds: 500),
    required this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.textStyle,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.keyboardType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.inputFormatters = const <TextInputFormatter>[],
    this.enabled = true,
    this.controller,
    this.autoDismissKeyboard = true,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.beforeTextPaste,
    this.onTap,
    this.keyboardAppearance,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.enablePinAutofill = true,
    this.showCursor = true,
    this.cursorColor,
    this.cursorWidth = 2,
    this.cursorHeight,
    this.errorText,
  }) : assert(
          obscuringCharacter.isNotEmpty,
          'obscuringCharacter cannot be empty',
        );

  /// length of how many cells there should be. 3-8 is recommended by me
  final int length;

  /// you already know what it does i guess :P default is false
  final bool obscureText;

  /// Character used for obscuring text if obscureText is true.
  ///
  /// Must not be empty. Single character is recommended.
  ///
  /// Default is ● - 'Black Circle' (U+25CF)
  final String obscuringCharacter;

  /// Decides whether typed character should be
  /// briefly shown before being obscured
  final bool blinkWhenObscuring;

  /// Blink Duration if blinkWhenObscuring is set to true
  final Duration blinkDuration;

  /// returns the current typed text in the fields
  final ValueChanged<String> onChanged;

  /// returns the typed text when all pins are set
  final ValueChanged<String>? onCompleted;

  /// returns the typed text when user presses done/next action on the keyboard
  final ValueChanged<String>? onSubmitted;

  /// the style of the text, default is [TextField] style
  final TextStyle? textStyle;

  /// background color for the whole row of pin code fields.
  final Color? backgroundColor;

  /// This defines how the elements in the pin code field align.
  /// Default to [MainAxisAlignment.spaceBetween]
  final MainAxisAlignment mainAxisAlignment;

  /// Duration for the animation. Default is [Duration(milliseconds: 150)]
  final Duration animationDuration;

  /// [Curve] for the animation. Default is [Curves.easeInOut]
  final Curve animationCurve;

  /// [TextInputType] for the pin code fields.
  /// default is [TextInputType.visiblePassword]
  final TextInputType keyboardType;

  /// If the pin code field should be autoFocused or not. Default is `false`
  final bool autoFocus;

  /// Should pass a [FocusNode] to manage it from the parent
  final FocusNode? focusNode;

  /// A list of [TextInputFormatter] that goes to the TextField
  final List<TextInputFormatter> inputFormatters;

  /// Enable or disable the Field. Default is `true`
  final bool enabled;

  /// [TextEditingController] to control the text manually.
  /// Sets a default [TextEditingController()] object if none given
  final TextEditingController? controller;

  /// Auto dismiss the keyboard upon inputting the value for the last field.
  /// Default is `true`
  final bool autoDismissKeyboard;

  /// Configures how the platform keyboard will select
  /// an uppercase or lowercase keyboard.
  /// Only supports text keyboards,
  /// other keyboard types will ignore this configuration.
  /// Capitalization is locale-aware.
  /// - Copied from 'https://api.flutter.dev/flutter/services/TextCapitalization-class.html'
  /// Default is [TextCapitalization.none]
  final TextCapitalization textCapitalization;

  final TextInputAction textInputAction;

  /// Callback method to validate if text can be pasted.
  /// This is helpful when we need to validate text before pasting.
  /// e.g. validate if text is number. Default will be pasted as received.
  final bool Function(String? text)? beforeTextPaste;

  /// Method for detecting a pin_code form tap
  /// work with all form windows
  final VoidCallback? onTap;

  /// Brightness dark or light choices for iOS keyboard.
  final Brightness? keyboardAppearance;

  /// Validator for the [TextFormField]
  final FormFieldValidator<String>? validator;

  /// An optional method to call with the final value when the form is saved via
  /// [FormState.save].
  final FormFieldSetter<String>? onSaved;

  /// enables auto validation for the [TextFormField]
  /// Default is false
  final AutovalidateMode autovalidateMode;

  /// Enables pin autofill for TextFormField.
  /// Default is true
  final bool enablePinAutofill;

  /// Whether to show cursor or not
  final bool showCursor;

  /// The color of the cursor, default to context.theme.primaryColor
  final Color? cursorColor;

  /// width of the cursor, default to 2
  final double cursorWidth;

  /// Height of the cursor, default to FontSize + 8;
  final double? cursorHeight;

  /// Error text
  final String? errorText;

  @override
  State<OtpTextInput> createState() => _OtpTextInputState();
}

class _OtpTextInputState extends State<OtpTextInput>
    with TickerProviderStateMixin {
  late TextEditingController _textEditingController;

  late FocusNode _focusNode;

  late List<String> _inputList;

  int _selectedIndex = 0;

  BorderRadius borderRadius = BorderRadius.circular(Dimens.dp8);

  // Whether the character has blinked
  late bool _hasBlinked;

  // AnimationController for the error animation
  late AnimationController _controller;

  late AnimationController _cursorController;

  // Animation for the error animation
  late Animation<Offset> _offsetAnimation;

  late Animation<double> _cursorAnimation;

  Timer? _blinkDebounce;

  TextStyle? get _textStyle =>
      context.adaptiveTheme.subTitleTextStyle?.merge(widget.textStyle);

  @override
  void initState() {
    _checkForInvalidValues();
    _assignController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    }); // Rebuilds on every change to reflect the correct color on each field.
    _inputList = List<String>.filled(widget.length, '');

    _hasBlinked = true;

    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cursorAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _cursorController,
        curve: Curves.easeIn,
      ),
    );
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.1, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
      ),
    );
    if (widget.showCursor) {
      _cursorController.repeat();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  // validating all the values
  void _checkForInvalidValues() {
    assert(widget.length > 0, 'Length of the pin code cannot be zero');
  }

  // Assigning the text controller, if empty assiging a new one.
  void _assignController() {
    _textEditingController = widget.controller ?? TextEditingController();
    _textEditingController.addListener(() {
      _debounceBlink();

      var currentText = _textEditingController.text;

      if (widget.enabled && _inputList.join() != currentText) {
        if (currentText.length >= widget.length) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.length) {
              // removing extra text longer than the length
              currentText = currentText.substring(0, widget.length);
            }
            //  delay the onComplete event handler to give the
            // onChange event handler enough time to complete
            Future.delayed(
              const Duration(milliseconds: 300),
              () => widget.onCompleted?.call(currentText),
            );
          }

          if (widget.autoDismissKeyboard) _focusNode.unfocus();
        }

        widget.onChanged(currentText);
      }

      _setTextToInput(currentText);
    });
  }

  void _debounceBlink() {
    // set has blinked to false and back to true
    // after duration
    if (widget.blinkWhenObscuring &&
        _textEditingController.text.length >
            _inputList.where((x) => x.isNotEmpty).length) {
      setState(() {
        _hasBlinked = false;
      });

      if (_blinkDebounce?.isActive ?? false) {
        _blinkDebounce?.cancel();
      }

      _blinkDebounce = Timer(widget.blinkDuration, () {
        setState(() {
          _hasBlinked = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();

    _cursorController.dispose();

    _controller.dispose();
    super.dispose();
  }

  // selects the right color for the field
  Color _getColorFromIndex(int index) {
    if (widget.errorText != null) {
      return context.theme.colorScheme.error;
    } else if (!widget.enabled) {
      return context.adaptiveTheme.disabledColor;
    } else if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus) {
      return context.adaptiveTheme.primaryColor;
    } else if (_selectedIndex > index) {
      return context.adaptiveTheme.tertiaryColor.withAlpha(51);
    }
    return context.adaptiveTheme.tertiaryColor.withAlpha(51);
  }

  Widget _renderPinField({
    required int index,
  }) {
    final showObscured = !widget.blinkWhenObscuring ||
        (widget.blinkWhenObscuring && _hasBlinked) ||
        index != _inputList.where((x) => x.isNotEmpty).length - 1;

    return Text(
      widget.obscureText && _inputList[index].isNotEmpty && showObscured
          ? widget.obscuringCharacter
          : _inputList[index],
      key: ValueKey(_inputList[index]),
      style: _textStyle,
    );
  }

  /// Builds the widget to be shown
  Widget buildChild(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus &&
        widget.showCursor) {
      final cursorColor =
          widget.cursorColor ?? context.adaptiveTheme.primaryColor;
      final cursorHeight =
          widget.cursorHeight ?? (_textStyle?.fontSize ?? 0) + 8;

      if (_selectedIndex == index + 1 && index + 1 == widget.length) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Padding(
                padding:
                    EdgeInsets.only(left: (_textStyle?.fontSize ?? 1) / 1.5),
                child: FadeTransition(
                  opacity: _cursorAnimation,
                  child: CustomPaint(
                    size: Size(0, cursorHeight),
                    painter: _CursorPainter(
                      cursorColor: cursorColor,
                      cursorWidth: widget.cursorWidth,
                    ),
                  ),
                ),
              ),
            ),
            _renderPinField(
              index: index,
            ),
          ],
        );
      } else {
        return Center(
          child: FadeTransition(
            opacity: _cursorAnimation,
            child: CustomPaint(
              size: Size(0, cursorHeight),
              painter: _CursorPainter(
                cursorColor: cursorColor,
                cursorWidth: widget.cursorWidth,
              ),
            ),
          ),
        );
      }
    }
    return _renderPinField(
      index: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: _offsetAnimation,
          child: Container(
            // adding the extra space at the bottom
            // to show the error text from validator
            height: 44,
            color: widget.backgroundColor,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                AbsorbPointer(
                  // it prevents on tap on the text field
                  child: AutofillGroup(
                    child: TextFormField(
                      textInputAction: widget.textInputAction,
                      controller: _textEditingController,
                      focusNode: _focusNode,
                      enabled: widget.enabled,
                      autofillHints: widget.enablePinAutofill && widget.enabled
                          ? <String>[AutofillHints.oneTimeCode]
                          : null,
                      autofocus: widget.autoFocus,
                      autocorrect: false,
                      keyboardType: widget.keyboardType,
                      keyboardAppearance: widget.keyboardAppearance,
                      textCapitalization: widget.textCapitalization,
                      validator: widget.validator,
                      onSaved: widget.onSaved,
                      autovalidateMode: widget.autovalidateMode,
                      inputFormatters: [
                        ...widget.inputFormatters,
                        LengthLimitingTextInputFormatter(
                          widget.length,
                        ), // this limits the input length
                      ],
                      // trigger on the complete event handler from the keyboard
                      onFieldSubmitted: widget.onSubmitted,
                      enableInteractiveSelection: false,
                      showCursor: false,
                      // using same as background color so tha
                      // it can blend into the view
                      cursorWidth: 0.01,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        fillColor: widget.backgroundColor ?? Colors.transparent,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.transparent,
                        height: .01,
                        fontSize: kIsWeb ? 1 : 0.01,
                        // it is a hidden textfield which should
                        // remain transparent and extremely small
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap?.call();
                      }

                      _onFocus();
                    },
                    child: Row(
                      mainAxisAlignment: widget.mainAxisAlignment,
                      children: _generateFields(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null) _buildErrorText(),
      ],
    );
  }

  List<Widget> _generateFields() {
    final result = <Widget>[];
    for (var i = 0; i < widget.length; i++) {
      result.add(
        AnimatedContainer(
          curve: widget.animationCurve,
          duration: widget.animationDuration,
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: _getColorFromIndex(i)),
          ),
          child: Center(
            child: AnimatedSwitcher(
              switchInCurve: widget.animationCurve,
              switchOutCurve: widget.animationCurve,
              duration: widget.animationDuration,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: buildChild(i),
            ),
          ),
        ),
      );
    }
    return result;
  }

  void _onFocus() {
    if (_focusNode.hasFocus && MediaQuery.of(context).viewInsets.bottom == 0) {
      _focusNode.unfocus();
      Future.delayed(
        const Duration(microseconds: 1),
        () => _focusNode.requestFocus(),
      );
    } else {
      _focusNode.requestFocus();
    }
  }

  Future<void> _setTextToInput(String data) async {
    final replaceInputList = List<String>.filled(widget.length, '');

    for (var i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : '';
    }

    if (mounted) {
      setState(() {
        _selectedIndex = data.length;
        _inputList = replaceInputList;
      });
    }
  }

  Widget _buildErrorText() {
    if (widget.errorText == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.dp16),
      child: Text(
        widget.errorText!,
        style: TextStyle(
          fontSize: Dimens.dp10,
          color: context.theme.colorScheme.error,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

enum PinCodeFieldShape { box, underline, circle }

enum ErrorAnimationType { shake }

class _CursorPainter extends CustomPainter {
  _CursorPainter({this.cursorColor = Colors.black, this.cursorWidth = 2});

  final Color cursorColor;
  final double cursorWidth;

  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset.zero;
    final p2 = Offset(0, size.height);
    final paint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
