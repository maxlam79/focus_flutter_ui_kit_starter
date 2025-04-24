import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../exports.dart';

class FUICalendarDateWheel extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final DateTime? initialSelectedDate;
  final FUICalendarDateWheelYearController? yearPager;
  final FUICalendarDateWheelDateController? dateController;
  final ItemScrollController? itemScrollController;
  final ValueChanged<DateTime>? onDateChanged;
  final Icon? prevYearBtnIcon;
  final Icon? nextYearBtnIcon;
  final TextStyle? yearTextStyle;
  final TextStyle? monthTextStyle;
  final TextStyle? monthSelectedTextStyle;
  final TextStyle? dayTextStyle;
  final TextStyle? daySelectedTextStyle;
  final TextStyle? dateTextStyle;
  final TextStyle? dateSelectedTextStyle;

  FUICalendarDateWheel({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.initialSelectedDate,
    this.yearPager,
    this.dateController,
    this.itemScrollController,
    this.onDateChanged,
    this.prevYearBtnIcon,
    this.nextYearBtnIcon,
    this.yearTextStyle,
    this.monthTextStyle,
    this.monthSelectedTextStyle,
    this.dayTextStyle,
    this.daySelectedTextStyle,
    this.dateTextStyle,
    this.dateSelectedTextStyle,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUICalendarDateWheel> createState() => _FUICalendarDateWheelState();
}

class _FUICalendarDateWheelState extends State<FUICalendarDateWheel> with FUIColorMixin {
  /// Theme
  late FUICalendarTheme fuiCalendar;

  /// BLoc
  late FUICalendarDateWheelYearController yearCtrl;
  late FUICalendarDateWheelDateController dateCtrl;
  bool blocProviderYearCreateNew = false;
  bool blocProviderDateCreateNew = false;

  /// Attributes and Flags
  late ItemScrollController itemScrollController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.initialSelectedDate ?? DateTime.now();
    itemScrollController = widget.itemScrollController ?? ItemScrollController();

    initBloc();
  }

  initBloc() {
    if (widget.yearPager == null) {
      blocProviderYearCreateNew = true;
    }

    if (widget.dateController == null) {
      blocProviderDateCreateNew = true;
    }

    yearCtrl = widget.yearPager ?? FUICalendarDateWheelYearController(selectedYear: selectedDate.year);
    dateCtrl = widget.dateController ?? FUICalendarDateWheelDateController(selectedDate: selectedDate);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiCalendar = context.theme.fuiCalendar;

    bf(BuildContext ctx, int selectedYear) {
      return SizedBox(
        width: double.infinity,
        child: FUIColumn(
          children: [
            _buildYearSelector(ctx, selectedYear),
            FUISpacer.vSpace5,
            _buildDateWheel(selectedYear),
          ],
        ),
      );
    }

    if (blocProviderYearCreateNew) {
      return BlocProvider<FUICalendarDateWheelYearController>(
        create: (_) => yearCtrl,
        child: BlocBuilder<FUICalendarDateWheelYearController, int>(
          bloc: yearCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider<FUICalendarDateWheelYearController>.value(
        value: yearCtrl,
        child: BlocBuilder<FUICalendarDateWheelYearController, int>(
          bloc: yearCtrl,
          builder: bf,
        ),
      );
    }
  }

  _buildYearSelector(BuildContext ctx, int selectedYear) {
    Color btnIconColor = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);

    Icon prevYearBtnIcon = widget.prevYearBtnIcon ??
        Icon(
          FUICalendarTheme.cdwDefaultLeftArrowIcon,
          size: FUICalendarTheme.cdwPrevYearBtnIconSize,
          color: btnIconColor,
        );

    Icon nextYearBtnIcon = widget.nextYearBtnIcon ??
        Icon(
          FUICalendarTheme.cdwDefaultRightArrowIcon,
          size: FUICalendarTheme.cdwNextYearBtnIconSize,
          color: btnIconColor,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DefaultTextStyle(
          style: widget.yearTextStyle ?? fuiCalendar.cdwYearTs,
          child: Text('$selectedYear'),
        ),
        FUISpacer.hSpace20,
        Padding(
          padding: FUICalendarTheme.yearPageBtnPadding,
          child: FUIButtonLinkIcon(
            icon: prevYearBtnIcon,
            onPressed: () {
              yearCtrl.prevYear();
            },
          ),
        ),
        FUISpacer.hSpace20,
        Padding(
          padding: FUICalendarTheme.yearPageBtnPadding,
          child: FUIButtonLinkIcon(
            icon: nextYearBtnIcon,
            onPressed: () {
              yearCtrl.nextYear();
            },
          ),
        ),
      ],
    );
  }

  _buildDateWheel(int selectedYear) {
    int noOfDays = _calcTotalDaysInYear(selectedYear);
    DateTime begin = DateTime(selectedYear, DateTime.january, 1);
    DateFormat df = DateFormat('yyyy-MM-dd');
    int scrollIdx = 0;

    // Calculate scroll position:
    if (selectedDate.year == selectedYear) {
      DateTime end = selectedDate;
      scrollIdx = end.difference(begin).inDays;

      if (scrollIdx > 11) {
        scrollIdx -= 11;
      }
    }

    bf(BuildContext ctx, DateTime selectedDate) {
      return SizedBox(
        height: FUICalendarTheme.cdwHeight,
        child: ScrollConfiguration(
          behavior: FUICalendarDateWheelScrollBehavior(),
          child: ScrollablePositionedList.builder(
            itemScrollController: widget.itemScrollController,
            initialScrollIndex: scrollIdx,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: noOfDays,
            itemBuilder: (ctx, i) {
              DateTime dt = begin.add(Duration(days: i));
              bool selected = false;

              if (df.format(dt) == df.format(selectedDate)) {
                selected = true;
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FUICalendarDateWheelDateSelector(
                  fuiColorScheme: widget.fuiColorScheme,
                  dateController: dateCtrl,
                  date: dt,
                  selected: selected,
                  onTap: widget.onDateChanged,
                  monthTextStyle: widget.monthTextStyle,
                  monthSelectedTextStyle: widget.monthSelectedTextStyle,
                  dayTextStyle: widget.dayTextStyle,
                  daySelectedTextStyle: widget.daySelectedTextStyle,
                  dateTextStyle: widget.dateTextStyle,
                  dateSelectedTextStyle: widget.dateSelectedTextStyle,
                ),
              );
            },
          ),
        ),
      );
    }

    if (blocProviderDateCreateNew) {
      return BlocProvider(
        create: (_) => dateCtrl,
        child: BlocBuilder(
          bloc: dateCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: dateCtrl,
        child: BlocBuilder(
          bloc: dateCtrl,
          builder: bf,
        ),
      );
    }
  }

  _calcTotalDaysInYear(int year) {
    DateTime begin = DateTime(year, DateTime.january, 1);
    DateTime end = DateTime(year, DateTime.december, 31);
    int totalDaysInYear = end.difference(begin).inDays + 1;

    return totalDaysInYear;
  }
}

class FUICalendarDateWheelScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        // etc.
      };
}

class FUICalendarDateWheelDateSelector extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUICalendarDateWheelDateController dateController;
  final DateTime date;
  final bool selected;
  final ValueChanged<DateTime>? onTap;
  final TextStyle? monthTextStyle;
  final TextStyle? monthSelectedTextStyle;
  final TextStyle? dayTextStyle;
  final TextStyle? daySelectedTextStyle;
  final TextStyle? dateTextStyle;
  final TextStyle? dateSelectedTextStyle;

  const FUICalendarDateWheelDateSelector({
    super.key,
    this.fuiColorScheme = FUIColorScheme.primary,
    required this.dateController,
    required this.date,
    this.selected = false,
    this.onTap,
    this.monthTextStyle,
    this.monthSelectedTextStyle,
    this.dayTextStyle,
    this.daySelectedTextStyle,
    this.dateTextStyle,
    this.dateSelectedTextStyle,
  });

  @override
  State<FUICalendarDateWheelDateSelector> createState() => _FUICalendarDateWheelDateSelectorState();
}

class _FUICalendarDateWheelDateSelectorState extends State<FUICalendarDateWheelDateSelector> with FUIColorMixin {
  /// Theme
  late FUICalendarTheme fuiCalendar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fuiCalendar = context.theme.fuiCalendar;

    String monthStr = (widget.date.day == 1) ? DateFormat('MMM').format(widget.date).toUpperCase() : '';
    String dayStr = DateFormat('EEE').format(widget.date).toUpperCase();
    String dateStr = DateFormat('dd').format(widget.date);

    TextStyle cdwMonthTs = widget.monthTextStyle ?? fuiCalendar.cdwMonthTs;
    TextStyle cdwDayTs = widget.dayTextStyle ?? fuiCalendar.cdwDayTs;
    TextStyle cdwDateTs = widget.dayTextStyle ?? fuiCalendar.cdwDateTs;

    if (widget.selected) {
      Color selectedColor = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);

      cdwMonthTs = widget.monthSelectedTextStyle ?? fuiCalendar.cdwMonthSelectedTs.copyWith(color: selectedColor);
      cdwDayTs = widget.daySelectedTextStyle ?? fuiCalendar.cdwDaySelectedTs.copyWith(color: selectedColor);
      cdwDateTs = widget.dateSelectedTextStyle ?? fuiCalendar.cdwDateTs.copyWith(color: selectedColor);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.dateController.selectDate(widget.date);

          if (widget.onTap != null) {
            widget.onTap!(widget.date);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              monthStr,
              style: cdwMonthTs,
            ),
            Text(
              dayStr,
              style: cdwDayTs,
            ),
            Text(
              dateStr,
              style: cdwDateTs,
            ),
          ],
        ),
      ),
    );
  }
}
