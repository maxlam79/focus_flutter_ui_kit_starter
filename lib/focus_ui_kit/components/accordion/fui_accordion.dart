import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIAccordion extends StatefulWidget {
  final FUIAccordionController? fuiAccordionController;
  final List<FUIAccordionItem> fuiAccordionItems;

  FUIAccordion({
    Key? key,
    this.fuiAccordionController,
    required this.fuiAccordionItems,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIAccordion> createState() => _FUIAccordionState();
}

class _FUIAccordionState extends State<FUIAccordion> {
  /// Bloc
  late FUIAccordionController accCtrl;
  late BlocProvider blocProvider;
  bool blocProviderCreateNew = false;

  /// Attributes and Flags
  Map<Key, ExpandableController> expCtrlMap = {};

  @override
  void initState() {
    super.initState();

    _initBloc();
    _initExpandableCtrls();
  }

  _initBloc() {
    if (widget.fuiAccordionController == null) {
      blocProviderCreateNew = true;
    }

    accCtrl = widget.fuiAccordionController ?? FUIAccordionController();
  }

  _initExpandableCtrls() {
    var itr = widget.fuiAccordionItems.iterator;

    while (itr.moveNext()) {
      FUIAccordionItem item = itr.current;

      if (item.initialExpanded) {
        expCtrlMap[item.key!] = ExpandableController(initialExpanded: item.initialExpanded);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> wList = [];
    var itr = widget.fuiAccordionItems.iterator;

    while (itr.moveNext()) {
      FUIAccordionItem item = itr.current;
      _FUIAccordionItemContentView cView = _FUIAccordionItemContentView(
        itemKey: item.key!,
        fuiAccordionController: accCtrl,
        initialExpanded: item.initialExpanded,
        height: item.contentHeight,
        padding: item.contentPadding,
        margin: item.contentMargin,
        child: item.content,
      );

      wList.add(item);
      wList.add(cView);
    }

    Widget bpChild = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: wList,
    );

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => accCtrl,
        child: bpChild,
      );
    } else {
      return BlocProvider.value(
        value: accCtrl,
        child: bpChild,
      );
    }
  }
}

class _FUIAccordionItemContentView extends StatefulWidget {
  final Key itemKey;
  final FUIAccordionController fuiAccordionController;
  final bool initialExpanded;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget child;

  _FUIAccordionItemContentView({
    Key? key,
    required this.itemKey,
    required this.fuiAccordionController,
    required this.initialExpanded,
    this.height,
    this.padding,
    this.margin,
    required this.child,
  }) : super(key: key ?? UniqueKey());

  @override
  State<_FUIAccordionItemContentView> createState() => _FUIAccordionItemContentViewState();
}

class _FUIAccordionItemContentViewState extends State<_FUIAccordionItemContentView> {
  /// Attributes and Flags
  late bool isExpanded;
  double currentHeight = 0;

  @override
  void initState() {
    super.initState();

    isExpanded = widget.initialExpanded;

    if (isExpanded) {
      currentHeight = widget.height ?? FUIAccordionTheme.accordionContentViewHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.fuiAccordionController,
      builder: (BuildContext context, FUIAccordionEvent? event) {
        if (event != null) {
          if (event.itemKey == widget.itemKey) {
            if (isExpanded != event.expand) {
              isExpanded = event.expand;
            }
          }
        }

        if (isExpanded) {
          currentHeight = widget.height ?? FUIAccordionTheme.accordionContentViewHeight;
        } else {
          currentHeight = 0;
        }

        return AnimatedContainer(
          padding: widget.padding ?? FUIAccordionTheme.accordionContentViewPadding,
          margin: widget.margin,
          duration: FUIAccordionTheme.accordionContentViewAniDuration,
          height: currentHeight,
          curve: Curves.ease,
          child: widget.child,
        );
      },
    );
  }
}
