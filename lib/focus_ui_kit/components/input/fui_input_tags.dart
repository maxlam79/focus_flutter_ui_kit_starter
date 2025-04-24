import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../exports.dart';

class FUIInputTags extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIInputFieldController? fuiInputFieldController;
  final StringTagController? stringTagController;
  final Validator<String>? tagStringValidator;
  final List<String>? initialTags;
  final List<String> tagSeparators;
  final String? tagPrefixString; // e.g. '#'
  final String? tagPostfixString;
  final TextStyle? tagTextStyle; // Overrides default textStyle
  final Color? tagBackgroundColor; // Overwrite fuiColorScheme's color
  final FUIInputTagShape fuiInputTagShape;
  final String? label;
  final String? hint;
  final bool mandatory;
  final Widget? mandatoryIndicator;
  final bool showTopLabelBar;
  final TextEditingController? textEditingController;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool selectAllOnFocus;
  final FUIInputSize fuiInputSize;
  final double? minWidth;
  final FUIInputStatusType fuiInputStatusType;
  final String? fuiInputStatusText;
  final Widget? sideIcon;
  final FUIInputSideIconPosition fuiInputSideIconPosition;
  final Color? sideIconBackgroundColor;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter? onSaved;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final Duration? enableOpacityAniDuration;
  final Curve? enableOpacityAniCurve;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;

  FUIInputTags({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiInputFieldController,
    this.stringTagController,
    this.tagStringValidator,
    this.initialTags,
    this.tagSeparators = const [' ', ','],
    this.tagPrefixString,
    this.tagPostfixString,
    this.tagTextStyle,
    this.tagBackgroundColor,
    this.fuiInputTagShape = FUIInputTagShape.rounded,
    this.label,
    this.hint,
    this.mandatory = false,
    this.mandatoryIndicator,
    this.showTopLabelBar = true,
    this.textEditingController,
    this.initialValue,
    this.focusNode,
    this.selectAllOnFocus = true,
    this.fuiInputSize = FUIInputSize.medium,
    this.minWidth = FUIInputTheme.minWidth,
    this.fuiInputStatusType = FUIInputStatusType.normal,
    this.fuiInputStatusText,
    this.sideIcon,
    this.fuiInputSideIconPosition = FUIInputSideIconPosition.right,
    this.sideIconBackgroundColor,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.keyboardType,
    this.textStyle,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscuringCharacter = '*',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.enableOpacityAniDuration,
    this.enableOpacityAniCurve,
    this.cursorWidth = FUIInputTheme.sizeCursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIInputTags> createState() => _FUIInputTagsState();
}

class _FUIInputTagsState<T> extends State<FUIInputTags> with FUIInputMixin, FUIColorMixin {
  /// Bloc
  late FUIInputFieldController ifCtrl;
  bool blocProviderCreateNew = false;

  /// Tags
  late StringTagController tagCtrl;

  /// Attributes and Flags
  late double _distanceToField;

  /// Keys
  GlobalKey inputLabelKey = GlobalKey();
  GlobalKey textFormFieldKey = GlobalKey();
  GlobalKey textFieldTagKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _initBloc();
    _initTagController();

    initOtherTextInputRelatedComponents(inputLabelKey, widget);
    initTextEditingController(widget);
    _initFocusNode();
  }

  _initBloc() {
    if (widget.fuiInputFieldController == null) {
      blocProviderCreateNew = true;
    }

    ifCtrl = widget.fuiInputFieldController ?? FUIInputFieldController();
  }

  _initTagController() {
    tagCtrl = widget.stringTagController ?? StringTagController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    tagCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    discernStyleParams(context, widget);
    buildMandatoryIndicator(context, widget);

    WidgetsBinding.instance.addPostFrameCallback((_) => discernTitleResize(widget));

    bf(BuildContext context, FUIInputFieldEvent? event) {
      _handleBlocEvent(event);

      discernContainerBorderColor(context, widget);

      List<Widget> mainContent = [];

      if (widget.sideIcon != null) {
        if (widget.fuiInputSideIconPosition == FUIInputSideIconPosition.left) {
          mainContent.add(
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: widget.sideIconBackgroundColor ?? fuiColors.shade1,
                border: Border(
                  right: BorderSide(
                    color: containerBorderColor,
                    width: FUIInputTheme.sizeContainerBorderThickness,
                  ),
                ),
              ),
              child: buildSideIcon(context, widget),
            ),
          );
        }
      }

      List<Widget> innerContent = [];

      if (widget.showTopLabelBar) {
        innerContent.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputFieldLabel,
            mandatoryIndicator,
          ],
        ));
      }

      innerContent.add(_buildTagFormField(context));

      mainContent.add(
        // Input Field Side
        Expanded(
          child: Container(
            margin: EdgeInsets.zero,
            padding: FUIInputTheme.paddingContainer,
            child: FUIColumn(
              children: innerContent,
            ),
          ),
        ),
      );

      if (widget.sideIcon != null) {
        if (widget.fuiInputSideIconPosition == FUIInputSideIconPosition.right) {
          mainContent.add(Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: widget.sideIconBackgroundColor ?? fuiColors.shade1,
              border: Border(
                left: BorderSide(
                  color: containerBorderColor,
                  width: FUIInputTheme.sizeContainerBorderThickness,
                ),
              ),
            ),
            child: buildSideIcon(context, widget),
          ));
        }
      }

      Widget inputFieldContainer = Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: widget.minWidth,
        decoration: BoxDecoration(
          color: discernContainerBackgroundColor(context, widget),
          shape: BoxShape.rectangle,
          border: Border.all(
            width: FUIInputTheme.sizeContainerBorderThickness,
            color: containerBorderColor,
          ),
          borderRadius: FUIInputTheme.sizeBorderRadius,
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: mainContent,
          ),
        ),
      );

      return AbsorbPointer(
        absorbing: isReadOnly,
        child: AnimatedOpacity(
          duration: widget.enableOpacityAniDuration ?? FUIInputTheme.enableOpacityAniDuration,
          curve: widget.enableOpacityAniCurve ?? FUIInputTheme.enableOpacityAniCurve,
          opacity: isEnabled ? FUIInputTheme.enableOpacityNormal : FUIInputTheme.enableOpacityDisabled,
          child: FUIColumn(
            children: [
              inputFieldContainer,
              FUISpacer.vSpace3,
              buildStatusContainer(context, widget),
            ],
          ),
        ),
      );
    }

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => ifCtrl,
        child: BlocBuilder(
          bloc: ifCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: ifCtrl,
        child: BlocBuilder(
          bloc: ifCtrl,
          builder: bf,
        ),
      );
    }
  }

  Widget _buildTagFormField(BuildContext context) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;

    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: fuiColors.shade2,
        ),
      ),
      child: TextFieldTags(
        key: textFieldTagKey,
        validator: widget.tagStringValidator,
        initialTags: widget.initialTags,
        textfieldTagsController: tagCtrl,
        textEditingController: textEditingController,
        focusNode: focusNode,
        textSeparators: widget.tagSeparators,
        inputFieldBuilder: (context, inputFieldValues) {
          return TextFormField(
            key: textFormFieldKey,
            onTap: () {
              tagCtrl.getFocusNode?.requestFocus();

              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            controller: inputFieldValues.textEditingController,
            focusNode: inputFieldValues.focusNode,
            decoration: _buildInputTagsDecoration(inputFieldValues),
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            style: textStyle,
            strutStyle: widget.strutStyle,
            textDirection: widget.textDirection,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            autofocus: widget.autofocus,
            readOnly: isReadOnly,
            showCursor: widget.showCursor,
            obscuringCharacter: widget.obscuringCharacter,
            obscureText: widget.obscureText,
            autocorrect: widget.autocorrect,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            enableSuggestions: widget.enableSuggestions,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            expands: widget.expands,
            maxLength: widget.maxLength,
            onTapOutside: widget.onTapOutside,
            onEditingComplete: widget.onEditingComplete,
            onSaved: widget.onSaved,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            enabled: isEnabled,
            cursorWidth: widget.cursorWidth,
            cursorHeight: widget.cursorHeight,
            cursorRadius: widget.cursorRadius,
            cursorColor: widget.cursorColor ?? fuiColors.primary,
            keyboardAppearance: widget.keyboardAppearance,
            scrollPadding: widget.scrollPadding,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            selectionControls: widget.selectionControls,
            buildCounter: widget.buildCounter,
            scrollPhysics: widget.scrollPhysics,
            autofillHints: widget.autofillHints,
            autovalidateMode: widget.autovalidateMode,
            scrollController: widget.scrollController,
            restorationId: widget.restorationId,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
            mouseCursor: widget.mouseCursor,
            onChanged: (String strValue) {
              inputFieldValues.onTagChanged(strValue);

              if (widget.onChanged != null) {
                widget.onChanged!(strValue);
              }
            },
            onFieldSubmitted: (strValue) {
              inputFieldValues.onTagSubmitted(strValue);

              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(strValue);
              }
            },
          );
        },
      ),
    );
  }

  InputDecoration _buildInputTagsDecoration(InputFieldValues inputFieldValues) {
    List<Widget> tagList = [];

    for (dynamic tag in inputFieldValues.tags) {
      tagList.add(_FUITag(
        tagValue: tag.toString(),
        tagPrefixString: widget.tagPrefixString,
        tagPostfixString: widget.tagPostfixString,
        fuiInputSize: widget.fuiInputSize,
        inputFieldValues: inputFieldValues,
        fuiColorScheme: widget.fuiColorScheme,
        tagTextStyle: widget.tagTextStyle,
        tagBackgroundColor: widget.tagBackgroundColor,
        fuiInputTagShape: widget.fuiInputTagShape,
      ));
    }

    return InputDecoration(
      contentPadding: contentPadding,
      isDense: true,
      border: InputBorder.none,
      hintText: (widget.hint != null) ? widget.hint! : null,
      hintStyle: hintStyle,
      counterText: '',
      prefixIconConstraints: BoxConstraints(maxWidth: _distanceToField * FUIInputTheme.tagDistanceToFieldFactor),
      prefixIcon: inputFieldValues.tags.isNotEmpty
          ? FUISingleChildScrollView(
              fuiColorScheme: widget.fuiColorScheme,
              controller: inputFieldValues.tagScrollController,
              scrollDirection: Axis.vertical,
              child: Wrap(
                runSpacing: FUIInputTheme.tagWrapRunSpacing,
                spacing: FUIInputTheme.tagWrapSpacing,
                children: tagList,
              ),
            )
          : null,
    );
  }

  _handleBlocEvent(FUIInputFieldEvent? event) {
    if (event != null) {
      if (event.enabled != null) {
        isEnabled = event.enabled!;
      }

      if (event.readOnly != null) {
        isReadOnly = event.readOnly!;
      }

      if (event.fuiInputStatusText != null) {
        inputStatusText = event.fuiInputStatusText!;
      }

      if (event.fuiInputStatusType != null) {
        inputStatusType = event.fuiInputStatusType!;
      }

      if (event.value != null) {
        textEditingController.text = event.value!;
      }
    }
  }

  _initFocusNode() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus || (tagCtrl.getTags != null && tagCtrl.getTags!.isNotEmpty)) {
        // Happens only for 1st time focus
        if (!isFocused && widget.selectAllOnFocus) {
          textEditingController.selection = TextSelection(baseOffset: 0, extentOffset: textEditingController.value.text.length);
        }

        isFocused = true;
        discernTitleResize(widget);
      } else {
        isFocused = false;
        discernTitleResize(widget);
      }
    });
  }
}

class _FUITag extends StatelessWidget with FUIColorMixin {
  final String tagValue;
  final String? tagPrefixString;
  final String? tagPostfixString;
  final FUIInputSize fuiInputSize;
  final InputFieldValues inputFieldValues;
  final FUIColorScheme fuiColorScheme;
  final TextStyle? tagTextStyle;
  final Color? tagBackgroundColor;
  final FUIInputTagShape fuiInputTagShape;

  const _FUITag({
    required this.tagValue,
    this.tagPrefixString,
    this.tagPostfixString,
    this.fuiInputSize = FUIInputSize.medium,
    required this.inputFieldValues,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.tagTextStyle,
    this.tagBackgroundColor,
    this.fuiInputTagShape = FUIInputTagShape.rounded,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = tagBackgroundColor ?? discernColorByScheme(context, fuiColorScheme: fuiColorScheme);
    TextStyle tStyle = tagTextStyle ?? _discernTextStyle(context, fuiColorScheme, fuiInputSize);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: tagValue, style: tStyle),
      textDirection: TextDirection.ltr,
      textScaler: TextScaler.linear(WidgetsBinding.instance.platformDispatcher.textScaleFactor),
      // textScaleFactor: WidgetsBinding.instance.platformDispatcher.textScaleFactor,
    )..layout();

    double cPlusWidth, cPlusHeight;
    EdgeInsets padding;

    switch (fuiInputSize) {
      case FUIInputSize.small:
        cPlusWidth = FUIInputTheme.tagContainerPlusWidthSmall;
        cPlusHeight = FUIInputTheme.tagContainerPlusHeightSmall;
        padding = FUIInputTheme.tagPaddingSmall;
        break;
      case FUIInputSize.large:
        cPlusWidth = FUIInputTheme.tagContainerPlusWidthLarge;
        cPlusHeight = FUIInputTheme.tagContainerPlusHeightLarge;
        padding = FUIInputTheme.tagPaddingLarge;
        break;
      case FUIInputSize.medium:
      default:
        cPlusWidth = FUIInputTheme.tagContainerPlusWidthMedium;
        cPlusHeight = FUIInputTheme.tagContainerPlusHeightMedium;
        padding = FUIInputTheme.tagPaddingMedium;
        break;
    }

    final double containerWidth = textPainter.width + cPlusWidth;
    final double containerHeight = textPainter.height + cPlusHeight;

    String displayTag = tagValue;

    if (tagPrefixString != null) {
      displayTag = '$tagPrefixString$displayTag';
    }

    if (tagPostfixString != null) {
      displayTag = '$displayTag$tagPostfixString';
    }

    Widget icon = IconTheme.merge(
      data: const IconThemeData().copyWith(
        color: tStyle.color,
        size: tStyle.fontSize,
      ),
      child: const Icon(CupertinoIcons.xmark),
    );

    return Padding(
      padding: padding,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: (fuiInputTagShape == FUIInputTagShape.rounded) ? FUIInputTheme.tagBorderRadius : null,
        ),
        child: Center(
          child: DefaultTextStyle(
            style: tStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(displayTag, softWrap: false),
                FUISpacer.hSpace5,
                InkWell(
                  child: icon,
                  onTap: () => inputFieldValues.onTagRemoved(tagValue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _discernTextStyle(
    BuildContext context,
    FUIColorScheme fuiColorScheme,
    FUIInputSize inputSize,
  ) {
    TextStyle tStyle;

    switch (fuiColorScheme) {
      case FUIColorScheme.papayaWhip:
      case FUIColorScheme.bumbleBee:
      case FUIColorScheme.lightGrey:
      case FUIColorScheme.banana:
      case FUIColorScheme.warning:
        switch (inputSize) {
          case FUIInputSize.small:
            tStyle = context.theme.fuiInput.tsTagTextPillBlackSmall;
            break;
          case FUIInputSize.large:
            tStyle = context.theme.fuiInput.tsTagTextPillBlackLarge;
            break;
          case FUIInputSize.medium:
          default:
            tStyle = context.theme.fuiInput.tsTagTextPillBlackMedium;
            break;
        }
        break;
      case FUIColorScheme.primary:
      case FUIColorScheme.secondary:
      case FUIColorScheme.ruby:
      case FUIColorScheme.tartOrange:
      case FUIColorScheme.opal:
      case FUIColorScheme.purple:
      case FUIColorScheme.berry:
      case FUIColorScheme.cobalt:
      case FUIColorScheme.teal:
      case FUIColorScheme.black:
      case FUIColorScheme.denim:
      case FUIColorScheme.prussian:
      case FUIColorScheme.success:
      case FUIColorScheme.complete:
      case FUIColorScheme.error:
      default:
        switch (inputSize) {
          case FUIInputSize.small:
            tStyle = context.theme.fuiInput.tsTagTextPillWhiteSmall;
            break;
          case FUIInputSize.large:
            tStyle = context.theme.fuiInput.tsTagTextPillWhiteLarge;
            break;
          case FUIInputSize.medium:
          default:
            tStyle = context.theme.fuiInput.tsTagTextPillWhiteMedium;
            break;
        }
        break;
    }

    return tStyle;
  }
}
