import 'package:avatar_stack/positions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../exports.dart';

class FUICalendarItem extends StatefulWidget {
  final Widget? dateIcon;
  final Widget date;
  final Widget? eventNameIcon;
  final Widget eventName;
  final bool eventNameDecoBarShow;
  final Color? eventNameDecoBarColor;
  final double? eventNameDecoBarThickness;
  final Widget? timeIcon;
  final Widget time;
  final Widget? venueIcon;
  final Widget? venue;
  final List<Widget>? tags;
  final double? tagsSpacing;
  final Widget? description;
  final Widget? avatars;
  final FUIPopupMenuIconButton? sidePopupMenuIconButton;
  final bool sidePopupMenuIconButtonShowOnHover;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BoxDecoration? borderDecoration;

  FUICalendarItem({
    Key? key,
    this.dateIcon,
    required this.date,
    this.eventNameIcon,
    required this.eventName,
    this.eventNameDecoBarShow = true,
    this.eventNameDecoBarColor,
    this.eventNameDecoBarThickness,
    this.timeIcon,
    required this.time,
    this.venueIcon,
    this.venue,
    this.tags,
    this.tagsSpacing,
    this.description,
    this.avatars,
    this.sidePopupMenuIconButton,
    this.sidePopupMenuIconButtonShowOnHover = true,
    this.padding,
    this.width,
    this.height,
    this.borderDecoration,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUICalendarItem> createState() => _FUICalendarItemState();
}

class _FUICalendarItemState extends State<FUICalendarItem> {
  late FUICalendarTheme fuiCalendar;
  late FUIThemeCommonColors fuiColors;
  late FUICalendarItemOptionBtnVisibleController btnVisibleCtrl;

  @override
  void initState() {
    super.initState();

    if (widget.sidePopupMenuIconButton != null && widget.sidePopupMenuIconButtonShowOnHover) {
      btnVisibleCtrl = FUICalendarItemOptionBtnVisibleController(showBtn: false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiCalendar = context.theme.fuiCalendar;
    fuiColors = context.theme.fuiColors;

    List<Widget> contentList = [];
    contentList.add(_buildHeader());

    if (widget.tags != null && widget.tags!.isNotEmpty) {
      contentList.add(_buildTags());
    }

    if (widget.description != null) {
      contentList.add(FUISpacer.vSpace15);
      contentList.add(_buildDescription());
    }

    if (widget.avatars != null) {
      contentList.add(FUISpacer.vSpace15);
      contentList.add(widget.avatars!);
    }

    var w = Container(
      constraints: BoxConstraints(
        minHeight: widget.height ?? FUICalendarTheme.ciContainerMinHeight,
      ),
      decoration: widget.borderDecoration ??
          BoxDecoration(
            color: fuiCalendar.ciBackgroundColor,
            border: Border.all(
              color: fuiCalendar.ciBorderColor,
            ),
            borderRadius: FUICalendarTheme.ciBoxBorderRadius,
          ),
      width: widget.width ?? double.infinity,
      padding: widget.padding ?? FUICalendarTheme.ciContainerPadding,
      child: FUIColumn(
        children: contentList,
      ),
    );

    if (widget.sidePopupMenuIconButton != null && widget.sidePopupMenuIconButtonShowOnHover) {
      return MouseRegion(
        onEnter: (_) {
          btnVisibleCtrl.toggleShowBtn(true);
        },
        onExit: (_) {
          btnVisibleCtrl.toggleShowBtn(false);
        },
        child: w,
      );
    }

    return w;
  }

  _buildHeader() {
    List<Widget> cList = [];

    cList.add(_buildHeaderDate());
    cList.add(FUISpacer.vSpace5);
    cList.add(_buildHeaderEventName());
    cList.add(FUISpacer.vSpace9);
    cList.add(_buildHeaderTime());

    if (widget.venue != null) {
      cList.add(FUISpacer.vSpace3);
      cList.add(_buildHeaderVenue());
    }

    cList.add(FUISpacer.vSpace7);

    FUIColumn headerCol = FUIColumn(
      children: cList,
    );

    List<Widget> rowBarList = [];
    rowBarList.add(headerCol);

    if (widget.sidePopupMenuIconButton != null) {
      if (widget.sidePopupMenuIconButtonShowOnHover) {
        rowBarList.add(_buildSidePopupMenuIconButton());
      } else {
        rowBarList.add(widget.sidePopupMenuIconButton!);
      }
    }

    return Row(
      mainAxisAlignment: widget.sidePopupMenuIconButton != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowBarList,
    );
  }

  _buildSidePopupMenuIconButton() {
    return BlocProvider(
      create: (_) => btnVisibleCtrl,
      child: BlocBuilder(
        bloc: btnVisibleCtrl,
        builder: (BuildContext ctx, bool showBtn) {
          return AnimatedOpacity(
            opacity: showBtn ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: widget.sidePopupMenuIconButton!,
          );
        },
      ),
    );
  }

  _buildHeaderDate() {
    List<Widget> rList = [];

    if (widget.dateIcon != null) {
      rList.add(IconTheme.merge(
        data: IconThemeData(
          color: fuiCalendar.ciDateTs.color,
          size: fuiCalendar.ciDateTs.fontSize,
        ),
        child: widget.dateIcon!,
      ));

      rList.add(FUISpacer.hSpace5);
    }

    rList.add(DefaultTextStyle(
      style: fuiCalendar.ciDateTs,
      child: widget.date,
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: rList,
    );
  }

  _buildHeaderEventName() {
    List<Widget> rList = [];

    if (widget.eventNameIcon != null) {
      rList.add(IconTheme.merge(
        data: IconThemeData(
          color: fuiCalendar.ciEventNameTs.color,
          size: fuiCalendar.ciEventNameTs.fontSize,
        ),
        child: widget.eventNameIcon!,
      ));

      rList.add(FUISpacer.hSpace5);
    }

    rList.add(DefaultTextStyle(
      style: fuiCalendar.ciEventNameTs,
      child: widget.eventName,
    ));

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: widget.eventNameDecoBarShow
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: widget.eventNameDecoBarThickness ?? FUICalendarTheme.ciDecoBarThicknessWidth,
                  color: widget.eventNameDecoBarColor ?? fuiColors.primary,
                ),
              ),
            )
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: rList,
            ),
          ),
          FUISpacer.vSpace4,
        ],
      ),
    );
  }

  _buildHeaderTime() {
    List<Widget> rList = [];

    if (widget.timeIcon != null) {
      rList.add(IconTheme.merge(
        data: IconThemeData(
          color: fuiCalendar.ciTimeTs.color,
          size: fuiCalendar.ciTimeTs.fontSize,
        ),
        child: widget.timeIcon!,
      ));

      rList.add(FUISpacer.hSpace5);
    }

    rList.add(DefaultTextStyle(
      style: fuiCalendar.ciTimeTs,
      child: widget.time,
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: rList,
    );
  }

  _buildHeaderVenue() {
    List<Widget> rList = [];

    if (widget.venueIcon != null) {
      rList.add(IconTheme.merge(
        data: IconThemeData(
          color: fuiCalendar.ciVenueTs.color,
          size: fuiCalendar.ciVenueTs.fontSize,
        ),
        child: widget.venueIcon!,
      ));

      rList.add(FUISpacer.hSpace5);
    }

    rList.add(DefaultTextStyle(
      style: fuiCalendar.ciVenueTs,
      child: widget.venue!,
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: rList,
    );
  }

  _buildTags() {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing: widget.tagsSpacing ?? FUICalendarTheme.ciTagsSpacing,
        children: widget.tags!,
      ),
    );
  }

  _buildDescription() {
    return DefaultTextStyle(
      style: fuiCalendar.ciDescTs,
      child: widget.description!,
    );
  }
}

class FUICalendarItemAvatarStack extends StatelessWidget {
  final FUIColorScheme fuiColorScheme;
  final List<Widget> avatars;
  final RestrictedPositions? settings;

  const FUICalendarItemAvatarStack({
    super.key,
    this.fuiColorScheme = FUIColorScheme.primary,
    required this.avatars,
    this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return FUIAvatarStack(
      avatars: avatars,
      settings: settings ??
          RestrictedPositions(
            maxCoverage: FUICalendarTheme.ciAvatarStackMaxConverge,
            minCoverage: FUICalendarTheme.ciAvatarStackMinConverge,
            align: StackAlign.right,
          ),
      height: FUICalendarTheme.ciAvatarStackHeight,
    );
  }
}

class FUICalendarAllDayItem extends StatefulWidget {
  final Widget? dateIcon;
  final Widget date;
  final Widget? eventNameIcon;
  final Widget eventName;
  final bool eventNameDecoBarShow;
  final Color? eventNameDecoBarColor;
  final double? eventNameDecoBarThickness;
  final Widget? venueIcon;
  final Widget? venue;
  final List<Widget>? tags;
  final double? tagsSpacing;
  final Widget? description;
  final Widget? avatars;
  final FUIPopupMenuIconButton? sidePopupMenuIconButton;
  final bool sidePopupMenuIconButtonShowOnHover;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BoxDecoration? borderDecoration;

  const FUICalendarAllDayItem({
    super.key,
    this.dateIcon,
    required this.date,
    this.eventNameIcon,
    required this.eventName,
    this.eventNameDecoBarShow = true,
    this.eventNameDecoBarColor,
    this.eventNameDecoBarThickness,
    this.venueIcon,
    this.venue,
    this.tags,
    this.tagsSpacing,
    this.description,
    this.avatars,
    this.sidePopupMenuIconButton,
    this.sidePopupMenuIconButtonShowOnHover = true,
    this.padding,
    this.width,
    this.height,
    this.borderDecoration,
  });

  @override
  State<FUICalendarAllDayItem> createState() => _FUICalendarAllDayItemState();
}

class _FUICalendarAllDayItemState extends State<FUICalendarAllDayItem> {
  late FUICalendarTheme fuiCalendar;
  late FUIThemeCommonColors fuiColors;
  late FUICalendarItemOptionBtnVisibleController btnVisibleCtrl;

  @override
  void initState() {
    super.initState();

    if (widget.sidePopupMenuIconButton != null && widget.sidePopupMenuIconButtonShowOnHover) {
      btnVisibleCtrl = FUICalendarItemOptionBtnVisibleController(showBtn: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    fuiCalendar = context.theme.fuiCalendar;
    fuiColors = context.theme.fuiColors;

    List<Widget> col1List = [];
    List<Widget> col2List = [];

    col1List.add(_buildHeaderDate());
    col1List.add(_buildHeaderEventName());

    if (widget.venue != null) {
      col1List.add(FUISpacer.vSpace10);
      col1List.add(_buildHeaderVenue());
    }

    if (widget.tags != null && widget.tags!.isNotEmpty) {
      col2List.add(_buildTags());
    }

    if (widget.description != null) {
      if (col2List.isNotEmpty) {
        col2List.add(FUISpacer.vSpace15);
      }

      col2List.add(_buildDescription());
    }

    if (widget.avatars != null) {
      if (col2List.isNotEmpty) {
        col2List.add(FUISpacer.vSpace15);
      }

      col2List.add(widget.avatars!);
    }

    var w = Container(
      constraints: BoxConstraints(
        minHeight: widget.height ?? FUICalendarTheme.ciAllDayContainerMinHeight,
      ),
      decoration: widget.borderDecoration ??
          BoxDecoration(
            color: fuiCalendar.ciBackgroundColor,
            border: Border.all(
              color: fuiCalendar.ciBorderColor,
            ),
            borderRadius: FUICalendarTheme.ciBoxBorderRadius,
          ),
      width: widget.width,
      padding: widget.padding ?? FUICalendarTheme.ciContainerPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  lg: 3,
                  md: 12,
                  child: FUIColumn(
                    children: col1List,
                  ),
                ),
                ResponsiveGridCol(
                  lg: 9,
                  md: 12,
                  child: Padding(
                    padding:
                        responsiveValue(context, lg: EdgeInsets.zero, md: EdgeInsets.only(top: 7), sm: EdgeInsets.only(top: 7), xs: EdgeInsets.only(top: 7)),
                    child: FUIColumn(
                      children: col2List,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildSidePopupMenuIconButton(),
        ],
      ),
    );

    if (widget.sidePopupMenuIconButton != null && widget.sidePopupMenuIconButtonShowOnHover) {
      return MouseRegion(
        onEnter: (_) {
          btnVisibleCtrl.toggleShowBtn(true);
        },
        onExit: (_) {
          btnVisibleCtrl.toggleShowBtn(false);
        },
        child: w,
      );
    }

    return w;
  }

  _buildSidePopupMenuIconButton() {
    return BlocProvider(
      create: (_) => btnVisibleCtrl,
      child: BlocBuilder(
        bloc: btnVisibleCtrl,
        builder: (BuildContext ctx, bool showBtn) {
          return AnimatedOpacity(
            opacity: showBtn ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: widget.sidePopupMenuIconButton!,
          );
        },
      ),
    );
  }

  _buildHeaderDate() {
    List<Widget> rList = [];

    if (widget.dateIcon != null) {
      rList.add(IconTheme.merge(
        data: IconThemeData(
          color: fuiCalendar.ciDateTs.color,
          size: fuiCalendar.ciDateTs.fontSize,
        ),
        child: widget.dateIcon!,
      ));

      rList.add(FUISpacer.hSpace5);
    }

    rList.add(DefaultTextStyle(
      style: fuiCalendar.ciDateTs,
      child: widget.date,
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: rList,
    );
  }

  _buildHeaderEventName() {
    List<Widget> rList = [];

    if (widget.eventNameIcon != null) {
      rList.add(IconTheme.merge(
        data: IconThemeData(
          color: fuiCalendar.ciEventNameTs.color,
          size: fuiCalendar.ciEventNameTs.fontSize,
        ),
        child: widget.eventNameIcon!,
      ));

      rList.add(FUISpacer.hSpace5);
    }

    rList.add(DefaultTextStyle(
      style: fuiCalendar.ciEventNameTs,
      child: widget.eventName,
    ));

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: widget.eventNameDecoBarShow
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: widget.eventNameDecoBarThickness ?? FUICalendarTheme.ciDecoBarThicknessWidth,
                  color: widget.eventNameDecoBarColor ?? fuiColors.primary,
                ),
              ),
            )
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: rList,
            ),
          ),
          FUISpacer.vSpace4,
        ],
      ),
    );
  }

  _buildHeaderVenue() {
    List<Widget> rList = [];

    if (widget.venueIcon != null) {
      rList.add(IconTheme.merge(
        data: IconThemeData(
          color: fuiCalendar.ciVenueTs.color,
          size: fuiCalendar.ciVenueTs.fontSize,
        ),
        child: widget.venueIcon!,
      ));

      rList.add(FUISpacer.hSpace5);
    }

    rList.add(DefaultTextStyle(
      style: fuiCalendar.ciVenueTs,
      child: widget.venue!,
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: rList,
    );
  }

  _buildTags() {
    return SizedBox(
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing: widget.tagsSpacing ?? FUICalendarTheme.ciTagsSpacing,
        children: widget.tags!,
      ),
    );
  }

  _buildDescription() {
    return DefaultTextStyle(
      style: fuiCalendar.ciDescTs,
      child: widget.description!,
    );
  }
}
