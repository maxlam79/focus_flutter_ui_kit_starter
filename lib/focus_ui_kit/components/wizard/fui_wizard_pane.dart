import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIWizardPane extends StatefulWidget {
  final FUIWizardPaneController? fuiWizardPaneController;
  final List<FUIWizardPageItem> pageItemList;
  final FUIWizardPageItemsPosition pageItemsPosition;
  final double contentViewHeight;
  final double pageItemsSectionLeftRightWidth; // Only applicable if items position is on the left or right.
  final int initialPageIndex;
  final double? itemSpaceBetween;
  final bool showPageItems;

  FUIWizardPane({
    Key? key,
    this.fuiWizardPaneController,
    required this.pageItemList,
    this.pageItemsPosition = FUIWizardPageItemsPosition.leftTop,
    this.contentViewHeight = FUIWizardTheme.defaultContentViewHeight,
    this.pageItemsSectionLeftRightWidth = FUIWizardTheme.defaultPageItemsSectionLeftRightWidth,
    this.initialPageIndex = 0,
    this.itemSpaceBetween = FUIWizardTheme.defaultItemSpaceBetween,
    this.showPageItems = true,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIWizardPane> createState() => _FUIWizardPaneState();
}

class _FUIWizardPaneState extends State<FUIWizardPane> {
  /// Theme
  late FUIThemeCommonColors fuiColors;

  /// Bloc
  late FUIWizardPaneController wizPaneCtrl;
  late FUIWizardPageItemSelectController wpisCtrl;
  bool blocProviderCreateNew = false;

  /// Attributes & Flags
  late Widget currentPageContent;
  int currentPageIdx = 0;
  bool initialLoad = true;

  @override
  void initState() {
    super.initState();

    _initBloc();
    _initPageAttrs();
  }

  _initBloc() {
    wizPaneCtrl = widget.fuiWizardPaneController ?? FUIWizardPaneController();

    if (widget.fuiWizardPaneController == null) {
      blocProviderCreateNew = true;
    }

    /// Use internally
    wpisCtrl = FUIWizardPageItemSelectController();
  }

  _initPageAttrs() {
    currentPageIdx = widget.initialPageIndex;
    currentPageContent = widget.pageItemList[currentPageIdx].content;
  }

  @override
  void dispose() {
    if (blocProviderCreateNew) {
      wizPaneCtrl.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    Widget w;

    switch (widget.pageItemsPosition) {
      case FUIWizardPageItemsPosition.topLeft:
      case FUIWizardPageItemsPosition.topCenter:
      case FUIWizardPageItemsPosition.topSpread:
      case FUIWizardPageItemsPosition.topRight:
        w = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildWizardTabs(),
            _buildWizardContent(),
          ],
        );
        break;
      case FUIWizardPageItemsPosition.bottomLeft:
      case FUIWizardPageItemsPosition.bottomCenter:
      case FUIWizardPageItemsPosition.bottomSpread:
      case FUIWizardPageItemsPosition.bottomRight:
        w = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildWizardContent(),
            _buildWizardTabs(),
          ],
        );
        break;
      case FUIWizardPageItemsPosition.leftTop:
      case FUIWizardPageItemsPosition.leftCenter:
      case FUIWizardPageItemsPosition.leftSpread:
      case FUIWizardPageItemsPosition.leftBottom:
        w = FUIRow(
          children: [
            _buildWizardTabs(),
            Expanded(
              child: _buildWizardContent(),
            ),
          ],
        );
        break;
      case FUIWizardPageItemsPosition.rightTop:
      case FUIWizardPageItemsPosition.rightCenter:
      case FUIWizardPageItemsPosition.rightSpread:
      case FUIWizardPageItemsPosition.rightBottom:
        w = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildWizardContent(),
            ),
            _buildWizardTabs(),
          ],
        );
        break;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: wizPaneCtrl),
        BlocProvider(
          create: (_) => wpisCtrl,
        )
      ],
      child: w,
    );
  }

  _buildWizardTabs() {
    if (!widget.showPageItems) {
      return const SizedBox.shrink();
    }

    Axis axis;
    MainAxisAlignment mainAxisAlignment;
    CrossAxisAlignment crossAxisAlignment;
    EdgeInsets padding;
    bool heightEnable = false;
    bool addHSpace = false;

    switch (widget.pageItemsPosition) {
      case FUIWizardPageItemsPosition.topLeft:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.start;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(bottom: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.topCenter:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.center;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(bottom: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.topSpread:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.spaceBetween;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(bottom: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.topRight:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.end;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(bottom: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.bottomLeft:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.start;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(top: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.bottomCenter:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.center;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(top: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.bottomSpread:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.spaceBetween;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(top: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.bottomRight:
        axis = Axis.horizontal;
        mainAxisAlignment = MainAxisAlignment.end;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(top: FUIWizardTheme.defaultTabPaddingTopBottom);
        addHSpace = true;
        break;
      case FUIWizardPageItemsPosition.leftCenter:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.center;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(right: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
      case FUIWizardPageItemsPosition.leftSpread:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.spaceBetween;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(right: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
      case FUIWizardPageItemsPosition.leftBottom:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.end;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(right: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
      case FUIWizardPageItemsPosition.rightTop:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.start;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(left: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
      case FUIWizardPageItemsPosition.rightCenter:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.center;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(left: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
      case FUIWizardPageItemsPosition.rightSpread:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.spaceBetween;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(left: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
      case FUIWizardPageItemsPosition.rightBottom:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.end;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(left: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
      case FUIWizardPageItemsPosition.leftTop:
      default:
        heightEnable = true;
        axis = Axis.vertical;
        mainAxisAlignment = MainAxisAlignment.start;
        crossAxisAlignment = CrossAxisAlignment.start;
        padding = const EdgeInsets.only(right: FUIWizardTheme.defaultTabPaddingLeftRight);
        break;
    }

    List<Widget> itemList = [];

    for (int i = 0; i < widget.pageItemList.length; i++) {
      if (i > 0) {
        itemList.add(addHSpace ? SizedBox(width: widget.itemSpaceBetween) : SizedBox(height: widget.itemSpaceBetween));
      }

      itemList.add(widget.pageItemList[i]);
    }

    Widget w = Padding(
      padding: padding,
      child: Flex(
        direction: axis,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: itemList,
      ),
    );

    if (heightEnable) {
      return SizedBox(
        height: widget.contentViewHeight,
        width: widget.pageItemsSectionLeftRightWidth,
        child: w,
      );
    }

    return w;
  }

  _buildWizardContent() {
    return BlocBuilder(
      bloc: wizPaneCtrl,
      builder: (BuildContext context, FUIWizardPaneEvent? event) {
        if (event != null) {
          if (event.nextPage != null && event.nextPage!) {
            if (currentPageIdx < widget.pageItemList.length - 1) {
              ++currentPageIdx;
            }
          } else if (event.prevPage != null && event.prevPage!) {
            if (currentPageIdx > 0) {
              --currentPageIdx;
            }
          } else if (event.gotoPageIdx != null && event.gotoPageIdx! >= 0 && event.gotoPageIdx! < widget.pageItemList.length) {
            currentPageIdx = event.gotoPageIdx!;
          } else if (event.gotoPageItemKey != null) {
            Key key = event.gotoPageItemKey!;

            for (int i = 0; i < widget.pageItemList.length; i++) {
              if (key.hashCode == widget.pageItemList[i].key!.hashCode) {
                currentPageIdx = i;
                break;
              }
            }
          }

          FUIWizardPageItem item = widget.pageItemList[currentPageIdx];
          currentPageContent = item.content;

          wpisCtrl.trigger(
            FUIWizardPageItemSelectEvent(
              selectedWizardItemKey: item.key!,
            ),
          );
        } else if (initialLoad) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            wpisCtrl.trigger(
              FUIWizardPageItemSelectEvent(
                selectedWizardItemKey: widget.pageItemList[currentPageIdx].key!,
              ),
            );
          });

          initialLoad = false;
        }

        return SizedBox(
          height: widget.contentViewHeight,
          width: double.infinity,
          child: currentPageContent,
        );
      },
    );
  }
}
