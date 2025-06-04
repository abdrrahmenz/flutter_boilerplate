import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextCursor extends StatefulWidget {
  const TextCursor({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.resumed = false,
    this.cursorColor = Colors.blue,
  });

  final Duration duration;
  final bool resumed;
  final Color cursorColor;

  @override
  State<TextCursor> createState() => _TextCursorState();
}

class _TextCursorState extends State<TextCursor>
    with SingleTickerProviderStateMixin {
  bool _displayed = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, _onTimer);
  }

  void _onTimer(Timer timer) {
    setState(() => _displayed = !_displayed);
  }

  @override
  void dispose() {
    const TextField();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Opacity(
        opacity: _displayed && widget.resumed ? 1.0 : 0.0,
        child: Container(
          width: 2.0,
          color: widget.cursorColor,
        ),
      ),
    );
  }
}

typedef ChipsBuilder<T> = Widget Function(
    BuildContext context, ChipsInputState<T> state, T data);
typedef ChipTextValidator = int Function(String value);

const kObjectReplacementChar = 0xFFFD;

extension on TextEditingValue {
  String get normalCharactersText => String.fromCharCodes(
        text.codeUnits.where((ch) => ch != kObjectReplacementChar),
      );

  List<int> get replacementCharacters => text.codeUnits
      .where((ch) => ch == kObjectReplacementChar)
      .toList(growable: false);

  int get replacementCharactersCount => replacementCharacters.length;
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    required Key key,
    this.decoration = const InputDecoration(),
    this.enabled = true,
    required this.width,
    this.chipBuilder,
    this.addChip,
    this.deleteChip,
    this.onChangedTag,
    this.initialTags = const <String>[],
    this.separator = ' ',
    required this.chipTextValidator,
    this.chipSpacing = 6,
    this.maxChips = 5,
    this.maxTagSize = 10,
    this.maxTagColor = Colors.red,
    this.cursorColor = Colors.blue,
    this.textStyle,
    this.countTextStyle = const TextStyle(color: Colors.black),
    this.countMaxTextStyle = const TextStyle(color: Colors.red),
    this.inputType = TextInputType.text,
    this.textOverflow = TextOverflow.clip,
    this.obscureText = false,
    this.autocorrect = true,
    this.actionLabel,
    this.inputAction = TextInputAction.done,
    this.keyboardAppearance = Brightness.light,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.focusNode,
  })  : assert(initialTags.length <= maxChips),
        assert(separator.length == 1),
        assert(chipSpacing > 0),
        super(key: key);

  final InputDecoration decoration;
  final TextStyle? textStyle;
  final double width;
  final bool enabled;
  final ChipsBuilder<T>? chipBuilder;
  final ValueChanged<String>? addChip;
  final Function()? deleteChip;
  final Function()? onChangedTag;
  final String separator;
  final ChipTextValidator chipTextValidator;
  final double chipSpacing;
  final int maxTagSize;
  final Color maxTagColor;
  final Color cursorColor;

  final List<String> initialTags;
  final int maxChips;
  final TextStyle countTextStyle;
  final TextStyle countMaxTextStyle;

  final TextInputType inputType;
  final TextOverflow textOverflow;
  final bool obscureText;
  final bool autocorrect;
  final String? actionLabel;
  final TextInputAction inputAction;
  final Brightness keyboardAppearance;
  final bool autofocus;
  final FocusNode? focusNode;

  final TextCapitalization textCapitalization;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>>
    implements TextInputClient {
  Set<T> _chips = <T>{};
  TextEditingValue _value = const TextEditingValue();
  TextInputConnection? _textInputConnection;
  Size? size;
  final Map<T, String> _enteredTexts = {};
  final List<String> _enteredTags = [];

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  TextInputConfiguration get textInputConfiguration => TextInputConfiguration(
        inputType: widget.inputType,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        actionLabel: widget.actionLabel,
        inputAction: widget.inputAction,
        keyboardAppearance: widget.keyboardAppearance,
        textCapitalization: widget.textCapitalization,
      );

  bool get _hasInputConnection =>
      _textInputConnection != null && _textInputConnection!.attached;

  final ScrollController _chipScrollController = ScrollController();

  final ScrollController _inputTextScrollController = ScrollController();

  double? _inputTextSize;
  // double? _countSizeBox;
  double? _chipBoxSize;

  @override
  void initState() {
    super.initState();

    for (var tag in widget.initialTags) {
      addChip(tag as T);
    }

    _enteredTags.addAll(widget.initialTags);

    _effectiveFocusNode.addListener(_handleFocusChanged);

    final String initText =
        String.fromCharCodes(_chips.map((_) => kObjectReplacementChar));

    TextEditingValue initValue = TextEditingValue(text: initText);

    initValue = initValue.copyWith(
      text: initText,
      selection: TextSelection.collapsed(offset: initText.length),
    );

    _textInputConnection ??= TextInput.attach(this, textInputConfiguration)
      ..setEditingState(initValue);

    _updateTextInput(putText: _value.normalCharactersText);

    _scrollToEnd(_inputTextScrollController);

    _chipBoxSize = widget.width * 0.7;
    _inputTextSize = widget.width * 0.1;
    // _countSizeBox = widget.width * 0.1;

    _chipScrollController.addListener(() {
      if (_chipScrollController.position.viewportDimension +
              _inputTextScrollController.position.viewportDimension >
          widget.width * 0.8) {
        _inputTextSize = _inputTextScrollController.position.viewportDimension;
        _chipBoxSize = widget.width * 0.8 - _inputTextSize!;
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted && widget.autofocus) {
        FocusScope.of(context).autofocus(_effectiveFocusNode);
      } else {
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _handleFocusChanged() {
    if (_effectiveFocusNode.hasFocus) {
      _openInputConnection();
    } else {
      _closeInputConnectionIfNeeded();
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _openInputConnection() {
    if (!_hasInputConnection) {
      _textInputConnection = TextInput.attach(this, textInputConfiguration)
        ..setEditingState(_value);
    }
    _textInputConnection!.show();

    Future.delayed(const Duration(milliseconds: 100), () {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        RenderObject? renderBox = context.findRenderObject();
        Scrollable.of(context).position.ensureVisible(renderBox!);
      });
    });
  }

  void _closeInputConnectionIfNeeded() {
    if (_hasInputConnection) {
      _textInputConnection!.close();
    }
  }

  List<String> getTags() {
    List<String> tags = [];
    for (var element in _chips) {
      tags.add(element.toString());
    }

    return tags;
  }

  void deleteChip(T data) {
    if (widget.enabled) {
      _chips.remove(data);
      if (_enteredTexts.containsKey(data)) {
        _enteredTexts.remove(data);
      }
      _updateTextInput(putText: _value.normalCharactersText);
    }
    if (widget.deleteChip != null) {
      widget.deleteChip!();
    }
  }

  @override
  void connectionClosed() {}

  @override
  TextEditingValue get currentTextEditingValue => _value;

  @override
  void performAction(TextInputAction action) {
    switch (action) {
      case TextInputAction.done:
        if (widget.separator == '\n') {
          String newTag = _value.normalCharactersText;
          if (newTag.isEmpty) {
            _updateTextInput();
            return;
          }
          _chips.add(newTag as T);
          if (widget.onChangedTag != null) {
            widget.onChangedTag!();
          }
          _enteredTags.add(newTag);
          _updateTextInput();
        }
        break;

      case TextInputAction.go:
      case TextInputAction.send:
      case TextInputAction.search:
      default:
        break;
    }
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    if (_chipScrollController.hasClients) {
      _inputTextSize =
          _inputTextScrollController.position.viewportDimension + 20;
      _chipBoxSize = widget.width * 0.8 -
          _inputTextScrollController.position.viewportDimension;
    }

    int index = widget.chipTextValidator(value.text);
    if (index == -1) {}

    var newTextEditingValue = value;
    var oldTextEditingValue = _value;

    if (newTextEditingValue.replacementCharactersCount >=
            oldTextEditingValue.replacementCharactersCount &&
        _chips.length >= widget.maxChips) {
      _updateTextInput();
      _textInputConnection!.setEditingState(_value);
      return;
    }

    if (newTextEditingValue.text != oldTextEditingValue.text) {
      if (newTextEditingValue.text == widget.separator) {
        _updateTextInput();
        return;
      }

      setState(() {
        _value = value;
      });

      if (newTextEditingValue.replacementCharactersCount <
          oldTextEditingValue.replacementCharactersCount) {
        _chips = Set.from(
            _chips.take(newTextEditingValue.replacementCharactersCount));
      }
      _updateTextInput(putText: _value.normalCharactersText);
    }

    String tagText = _value.normalCharactersText;
    if (tagText.isNotEmpty) {
      String lastString = tagText.substring(tagText.length - 1);
      if (tagText.length >= widget.maxTagSize &&
          lastString != widget.separator) {
        _updateTextInput(putText: tagText.substring(0, widget.maxTagSize));
        return;
      }

      if (lastString == widget.separator) {
        String newTag = tagText.substring(0, tagText.length - 1);
        if (newTag.isEmpty) {
          _updateTextInput();
          return;
        }
        _chips.add(newTag as T);
        if (widget.onChangedTag != null) {
          widget.onChangedTag!();
        }
        _enteredTags.add(newTag);
        _updateTextInput();
      }
    }
  }

  void addChip(T data) {
    String enteredText = _value.normalCharactersText;
    if (enteredText.isNotEmpty) _enteredTexts[data] = enteredText;
    _chips.add(data);
  }

  void _updateTextInput({String putText = ''}) {
    final String updatedText =
        String.fromCharCodes(_chips.map((_) => kObjectReplacementChar)) +
            putText;
    setState(() {
      _value = _value.copyWith(
        text: updatedText,
        selection: TextSelection.collapsed(offset: updatedText.length),
      );
    });

    _textInputConnection ??= TextInput.attach(this, textInputConfiguration);

    _textInputConnection!.setEditingState(_value);
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {}

  void _scrollToEnd(ScrollController controller) {
    Timer(const Duration(milliseconds: 100), () {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chipsChildren = _chips
        .map<Widget>((data) => widget.chipBuilder!(context, this, data))
        .toList();
    Widget chipsBox = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: _chipBoxSize!,
      ),
      child: SingleChildScrollView(
        controller: _chipScrollController,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: widget.chipSpacing,
          children: chipsChildren,
        ),
      ),
    );

    // int maxCount = widget.maxChips;
    // int currentCount = chipsChildren.length;

    List<String> tagAll = [];
    for (var element in _chips) {
      tagAll.add(element.toString());
    }

    _scrollToEnd(_chipScrollController);
    _scrollToEnd(_inputTextScrollController);

    // Widget countWidget = const SizedBox.shrink();
    // TextStyle countWidgetTextStyle = widget.countTextStyle;
    // if (widget.maxChips <= chipsChildren.length) {
    //   countWidgetTextStyle = widget.countMaxTextStyle;
    // }
    // countWidget = Text("$currentCount/$maxCount", style: countWidgetTextStyle);

    double leftPaddingSize = 0;
    if (_chips.isNotEmpty) {
      leftPaddingSize = widget.chipSpacing;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // FocusScope.of(context).requestFocus(_effectiveFocusNode);
        if (!_hasInputConnection) {
          _textInputConnection = TextInput.attach(this, textInputConfiguration)
            ..setEditingState(_value);
        }
        _textInputConnection!.show();
      },
      child: InputDecorator(
        decoration: widget.decoration,
        isFocused: _effectiveFocusNode.hasFocus,
        isEmpty: _value.text.isEmpty && _chips.isEmpty,
        child: Row(
          children: <Widget>[
            Flexible(child: chipsBox),
            Padding(
              padding: EdgeInsets.only(left: leftPaddingSize),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: _inputTextSize!,
                maxHeight: 32.0,
              ),
              child: SingleChildScrollView(
                controller: _inputTextScrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Text(
                          _value.normalCharactersText,
                          maxLines: 1,
                          overflow: widget.textOverflow,
                          style: widget.textStyle,
                          //style: TextStyle(height: _textStyle.height, color: c, fontFamily: _textStyle.fontFamily, fontSize: _textStyle.fontSize),
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 0,
                        child: TextCursor(
                          resumed: _effectiveFocusNode.hasFocus,
                          cursorColor: widget.cursorColor,
                        )),
                  ],
                ),
              ),
            ),
            // const Spacer(),
            // SizedBox(
            //     width: _countSizeBox,
            //     child: Row(
            //       children: <Widget>[
            //         const Padding(
            //           padding: EdgeInsets.only(left: 8),
            //         ),
            //         countWidget,
            //       ],
            //     )),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement currentAutofillScope
  AutofillScope get currentAutofillScope => throw UnimplementedError();

  @override
  void showAutocorrectionPromptRect(int start, int end) {
    // TODO: implement showAutocorrectionPromptRect
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {
    // TODO: implement performPrivateCommand
  }

  @override
  void insertTextPlaceholder(Size size) {
    // TODO: implement insertTextPlaceholder
  }

  @override
  void removeTextPlaceholder() {
    // TODO: implement removeTextPlaceholder
  }

  @override
  void showToolbar() {
    // TODO: implement showToolbar
  }

  @override
  void didChangeInputControl(
      TextInputControl? oldControl, TextInputControl? newControl) {
    // TODO: implement didChangeInputControl
  }

  @override
  void insertContent(KeyboardInsertedContent content) {
    // TODO: implement insertContent
  }

  @override
  void performSelector(String selectorName) {
    // TODO: implement performSelector
  }
}
