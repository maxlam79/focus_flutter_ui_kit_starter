import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../exports.dart';

class FUIInputDate extends StatefulWidget {
  final FUIInputFieldController? fuiInputFieldController;
  final String? label;
  final String? hint;
  final bool mandatory;
  final Widget? mandatoryIndicator;
  final bool showTopLabelBar;
  final CalendarDatePicker2Type calendarDatePicker2Type;
  final TextEditingController? textEditingController;
  final String? initialValue;
  final String dateFormat;
  final String dateRangeDelimiter;
  final FocusNode? focusNode;
  final bool selectAllOnFocus;
  final FUIInputSize fuiInputSize;
  final double? minWidth;
  final FUIInputStatusType fuiInputStatusType;
  final String? fuiInputStatusText;
  final Widget? sideIcon;
  final FUIInputSideIconPosition fuiInputSideIconPosition;
  final Color? sideIconBackgroundColor;
  final FUIPickerDisplayMode fuiPickerDisplayMode;
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

  FUIInputDate({
    Key? key,
    this.fuiInputFieldController,
    this.label,
    this.hint,
    this.mandatory = false,
    this.mandatoryIndicator,
    this.showTopLabelBar = true,
    this.calendarDatePicker2Type = CalendarDatePicker2Type.single,
    this.textEditingController,
    this.initialValue,
    this.dateFormat = 'MM/dd/yyyy',
    this.dateRangeDelimiter = ' - ',
    this.focusNode,
    this.selectAllOnFocus = true,
    this.fuiInputSize = FUIInputSize.medium,
    this.minWidth = FUIInputTheme.minWidth,
    this.fuiInputStatusType = FUIInputStatusType.normal,
    this.fuiInputStatusText,
    this.sideIcon,
    this.fuiInputSideIconPosition = FUIInputSideIconPosition.right,
    this.sideIconBackgroundColor,
    this.fuiPickerDisplayMode = FUIPickerDisplayMode.popover,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.keyboardType,
    this.textStyle,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = true,
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
  State<FUIInputDate> createState() => _FUIInputDateState();
}

class _FUIInputDateState extends State<FUIInputDate> with FUIInputMixin {
  /// Bloc
  late FUIInputFieldController ifCtrl;
  bool blocProviderCreateNew = false;

  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUIInputTheme fuiInputTheme;

  /// Keys
  GlobalKey inputLabelKey = GlobalKey();
  GlobalKey textFormFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _initBloc();

    initOtherTextInputRelatedComponents(inputLabelKey, widget);
    initTextEditingController(widget);
    initFocusNode(widget);
  }

  _initBloc() {
    if (widget.fuiInputFieldController == null) {
      blocProviderCreateNew = true;
    }

    ifCtrl = widget.fuiInputFieldController ?? FUIInputFieldController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiInputTheme = context.theme.fuiInput;
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
        innerContent.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputFieldLabel,
              mandatoryIndicator,
            ],
          ),
        );
      }

      innerContent.add(_buildTextFormField(context));

      mainContent.add(
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
          mainContent.add(
            Container(
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
            ),
          );
        }
      }

      return Container(
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
    }

    Widget w = blocProviderCreateNew
        ? BlocProvider(
            create: (_) => ifCtrl,
            child: BlocBuilder(
              bloc: ifCtrl,
              builder: bf,
            ),
          )
        : BlocProvider.value(
            value: ifCtrl,
            child: BlocBuilder(
              bloc: ifCtrl,
              builder: bf,
            ),
          );

    return FUIColumn(
      spacing: 3,
      children: [
        w,
        buildStatusContainer(context, widget),
      ],
    );
  }

  Widget _buildTextFormField(BuildContext context) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;

    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: fuiColors.shade2,
        ),
      ),
      child: TextFormField(
        key: textFormFieldKey,
        controller: textEditingController,
        focusNode: focusNode,
        decoration: buildInputDecoration(widget),
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        style: textStyle,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
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
        onChanged: widget.onChanged,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!;
          }

          _displayPicker();
        },
        onTapOutside: widget.onTapOutside,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
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
      ),
    );
  }

  _displayPicker() {
    if (widget.fuiPickerDisplayMode == FUIPickerDisplayMode.popover) {
      showPopover(
        context: context,
        bodyBuilder: (context) {
          return _buildCalendarDatePicker2(context);
        },
        onPop: () {
          if (ModalRoute.of(context)!.isCurrent) {
            isPopoverOrDialogShow = true;
            discernTitleResize(widget);
          } else {
            isPopoverOrDialogShow = false;
            discernTitleResize(widget);
          }
        },
        direction: PopoverDirection.bottom,
        width: FUIInputTheme.sizeDatePopupWidth,
        height: FUIInputTheme.sizeDatePopupHeight,
        arrowHeight: FUIInputTheme.sizeDatePopupArrowHeight,
        arrowWidth: FUIInputTheme.sizeDatePopupArrowWidth,
      );
    } else {
      showDialog(
        context: context,
        barrierColor: fuiInputTheme.barrierColor,
        builder: (context) {
          return Dialog(
            surfaceTintColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: FUIInputTheme.sizeBorderRadius,
            ),
            insetPadding: responsiveValue(context, md: null, sm: EdgeInsets.zero, xs: EdgeInsets.zero),
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: fuiColors.bg0,
                borderRadius: FUIInputTheme.sizeBorderRadius,
              ),
              width: FUIInputTheme.sizeDatePickerDialogWidth,
              child: _buildCalendarDatePicker2(context),
            ),
          );
        },
      );
    }
  }

  Widget _buildCalendarDatePicker2(BuildContext context) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    FUIInputTheme fuiInputTheme = context.theme.fuiInput;

    return Theme(
      data: context.theme.copyWith(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: CalendarDatePicker2(
        onValueChanged: (dateTimeList) {
          textEditingController.text = _convertToDisplayText(dateTimeList);

          if (widget.onChanged != null) {
            widget.onChanged!(textEditingController.text);
          }
        },
        config: CalendarDatePicker2Config(
          calendarType: widget.calendarDatePicker2Type,
          selectedDayHighlightColor: fuiColors.primary,
          centerAlignModePicker: true,
          controlsTextStyle: fuiInputTheme.tsDateControls,
          dayTextStyle: fuiInputTheme.tsDateDay,
          disabledDayTextStyle: fuiInputTheme.tsDateDisplayDay,
          selectedDayTextStyle: fuiInputTheme.tsDateSelectedDay,
          selectedYearTextStyle: fuiInputTheme.tsDateSelectedYear,
          todayTextStyle: fuiInputTheme.tsDateToday,
          yearTextStyle: fuiInputTheme.tsDateYear,
          weekdayLabelTextStyle: fuiInputTheme.tsWeekdayLabel,
        ),
        value: _convertToDateTimeList(textEditingController.value.text),
      ),
    );
  }

  String _convertToDisplayText(List<DateTime?> dateTimeList) {
    if (dateTimeList.isNotEmpty) {
      if (dateTimeList.length == 1) {
        return DateFormat(widget.dateFormat).format(dateTimeList.single!);
      } else {
        String displayText = DateFormat(widget.dateFormat).format(dateTimeList.first!);

        for (int i = 1; i < dateTimeList.length; i++) {
          displayText += widget.dateRangeDelimiter + DateFormat(widget.dateFormat).format(dateTimeList[i]!);
        }

        return displayText;
      }
    }

    return '';
  }

  List<DateTime?> _convertToDateTimeList(String? dateTimeStr) {
    if (dateTimeStr != null && dateTimeStr.trim().isNotEmpty) {
      try {
        List<String> dateTimeStrList = dateTimeStr.split(widget.dateRangeDelimiter);
        List<DateTime?> dateTimeList = [];
        var itr = dateTimeStrList.iterator;

        while (itr.moveNext()) {
          dateTimeList.add(DateFormat(widget.dateFormat).parse(itr.current.trim()));
        }

        return dateTimeList;
      } catch (e) {
        return [];
      }
    }

    return [];
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

      if (event.value != null) {
        textEditingController.text = event.value!;
      }
    }
  }
}
