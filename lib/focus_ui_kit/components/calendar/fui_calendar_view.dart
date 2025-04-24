import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../exports.dart';

class FUICalendarView extends StatefulWidget {
  final EdgeInsets padding;
  final Widget? title;
  final EdgeInsets titlePadding;
  final double minHeight;
  final List<FUICalendarAllDayItem>? allDayItems;
  final List<FUICalendarItem>? items;
  final Widget? noItemsMessage;
  final double desiredItemWidth;
  final double minSpacing;
  final bool shrinkWrap;
  final EdgeInsets allDayItemPadding;

  FUICalendarView({
    Key? key,
    this.padding = FUICalendarTheme.cvPadding,
    this.minHeight = FUICalendarTheme.cvMinHeight,
    this.title,
    this.titlePadding = FUICalendarTheme.cvTitlePadding,
    this.allDayItems,
    this.items,
    this.noItemsMessage,
    this.desiredItemWidth = FUICalendarTheme.cvDesiredItemWidth,
    this.minSpacing = FUICalendarTheme.cvMinSpacing,
    this.shrinkWrap = true,
    this.allDayItemPadding = FUICalendarTheme.cvAllDayItemPadding,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUICalendarView> createState() => _FUICalendarViewState();
}

class _FUICalendarViewState extends State<FUICalendarView> {
  late FUITypographyTheme fuiTypography;

  @override
  Widget build(BuildContext context) {
    fuiTypography = context.theme.fuiTypography;

    dynamic content;

    if ((widget.allDayItems == null || widget.allDayItems!.isEmpty) && (widget.items == null || widget.items!.isEmpty)) {
      content = _buildNoItemsMsg();
    } else {
      content = _buildContent(context);
    }

    return Container(
      margin: EdgeInsets.zero,
      padding: widget.padding,
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
      ),
      child: FUIColumn(
        children: [
          _buildTitle(context),
          content,
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
    if (widget.title != null) {
      return Padding(
        padding: widget.titlePadding,
        child: DefaultTextStyle(style: context.theme.fuiTypography.h5, child: widget.title!),
      );
    }

    return const SizedBox.shrink();
  }

  _buildContent(BuildContext context) {
    List<Widget> wList = [];

    if (widget.allDayItems != null && widget.allDayItems!.isNotEmpty) {
      for (var w in widget.allDayItems!) {
        wList.add(Padding(
          padding: widget.allDayItemPadding,
          child: w,
        ));
      }
    }

    if (widget.items != null && widget.items!.isNotEmpty) {
      wList
        ..add(FUISpacer.vSpace10)
        ..add(ResponsiveGridList(
          desiredItemWidth: widget.desiredItemWidth,
          shrinkWrap: widget.shrinkWrap,
          minSpacing: widget.minSpacing,
          children: widget.items!,
        ));
    }

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: FUIColumn(
        children: wList,
      ),
    );
  }

  _buildNoItemsMsg() {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Center(
        child: DefaultTextStyle(
          style: fuiTypography.smallText,
          child: widget.noItemsMessage ?? const Text('No events'),
        ),
      ),
    );
  }
}
