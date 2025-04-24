import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIExpMenu extends StatefulWidget {
  final FUIExpMenuController? fuiMenuController;
  final List<FUIMenuItem> fuiMenuItems;

  FUIExpMenu({
    Key? key,
    this.fuiMenuController,
    required this.fuiMenuItems,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIExpMenu> createState() => _FUIExpMenuState();
}

class _FUIExpMenuState extends State<FUIExpMenu> {
  /// Bloc
  late FUIExpMenuController menuCtrl;
  bool blocProviderNewCreate = false;

  /// Attributes and Flags
  late List<Widget> expMenuItems;

  @override
  void initState() {
    super.initState();

    _initBloc();

    expMenuItems = _buildExpandableMenuItems();
  }

  _initBloc() {
    if (widget.fuiMenuController == null) {
      blocProviderNewCreate = true;
    }

    menuCtrl = widget.fuiMenuController ?? FUIExpMenuController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget bpChild = Container(
      margin: EdgeInsets.zero,
      child: Column(
        children: expMenuItems,
      ),
    );

    if (blocProviderNewCreate) {
      return BlocProvider(
        create: (_) => menuCtrl,
        child: bpChild,
      );
    } else {
      return BlocProvider.value(
        value: menuCtrl,
        child: bpChild,
      );
    }
  }

  List<Widget> _buildExpandableMenuItems() {
    List<Widget> expNList = [];
    var itr = widget.fuiMenuItems.iterator;

    while (itr.moveNext()) {
      var menuItem = itr.current;
      var subMenuItems = menuItem.fuiSubMenuItems;

      List<Widget> expendedList = [menuItem];

      if (subMenuItems != null) {
        var itr2 = subMenuItems.iterator;

        while (itr2.moveNext()) {
          var subMenuItem = itr2.current;
          expendedList.add(subMenuItem);
        }
      }

      ExpandableController expCtrl;

      if (menuCtrl.lastMenuItemKey != null) {
        bool selected = (menuCtrl.lastMenuItemKey!.hashCode == menuItem.key!.hashCode);
        expCtrl = ExpandableController(initialExpanded: selected);
      } else {
        expCtrl = ExpandableController(initialExpanded: menuItem.selected);
      }

      // ExpandableController expCtrl = ExpandableController(initialExpanded: menuItem.selected);

      expNList.add(
        BlocBuilder<FUIExpMenuController, FUIExpMenuEvent?>(
          builder: (BuildContext context, FUIExpMenuEvent? event) {
            if (event != null && event.selectedMenuKey != null && menuItem.key != null) {
              if (event.selectedMenuKey == menuItem.key) {
                expCtrl.expanded = true;
              } else {
                expCtrl.expanded = false;
              }
            }

            return ExpandableNotifier(
              controller: expCtrl,
              child: Expandable(
                collapsed: menuItem,
                expanded: Container(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: expendedList,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return expNList;
  }
}
