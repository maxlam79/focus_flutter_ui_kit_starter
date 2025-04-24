import 'package:flutter/material.dart';

import '../../exports.dart';

class FUIPopupMenuItem {
  final dynamic value;
  final Icon? icon;
  final FUIPopupMenuItemIconPosition iconPosition;
  final Widget label;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool enabled;

  const FUIPopupMenuItem({
    this.value,
    this.icon,
    this.iconPosition = FUIPopupMenuItemIconPosition.left,
    required this.label,
    this.padding,
    this.onTap,
    this.enabled = true,
  });
}

class FUIPopupMenuIconButton extends StatefulWidget {
  final Icon icon;
  final List<FUIPopupMenuItem> fuiPopupMenuItemList;

  FUIPopupMenuIconButton({
    Key? key,
    this.icon = const Icon(FUIPopupMenuTheme.defaultPopupMenuBtnIcon),
    required this.fuiPopupMenuItemList,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIPopupMenuIconButton> createState() => _FUIPopupMenuIconButtonState();
}

class _FUIPopupMenuIconButtonState extends State<FUIPopupMenuIconButton> {
  late FUIThemeCommonColors fuiColors;
  late FUIPopupMenuTheme fuiPopupMenuTheme;

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiPopupMenuTheme = context.theme.fuiPopupMenu;

    return Theme(
      data: context.theme.copyWith(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        buttonTheme: const ButtonThemeData().copyWith(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        visualDensity: VisualDensity.compact,
        popupMenuTheme: const PopupMenuThemeData().copyWith(
          surfaceTintColor: Colors.transparent,
          color: fuiColors.shade0,
        ),
      ),
      child: PopupMenuButton(
        icon: IconTheme.merge(
          data: context.theme.iconTheme.copyWith(
            color: fuiPopupMenuTheme.btnIconColor,
            size: FUIPopupMenuTheme.btnIconSize,
          ),
          child: widget.icon,
        ),
        itemBuilder: (_) {
          List<PopupMenuItem> itemList = [];

          for (FUIPopupMenuItem item in widget.fuiPopupMenuItemList) {
            itemList.add(_buildPopupMenuItem(item));
          }

          return itemList;
        },
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(FUIPopupMenuItem item) {
    Widget itemWidget;

    var label = DefaultTextStyle(
      style: fuiPopupMenuTheme.itemTs,
      child: item.label,
    );

    var icon = (item.icon != null)
        ? IconTheme.merge(
            data: context.theme.iconTheme.copyWith(
              color: fuiPopupMenuTheme.itemTextColor,
              size: FUIPopupMenuTheme.itemIconSize,
            ),
            child: item.icon!,
          )
        : null;

    if (icon == null) {
      itemWidget = label;
    } else {
      List<Widget> wList = [];

      switch (item.iconPosition) {
        case FUIPopupMenuItemIconPosition.right:
          wList = [label, FUISpacer.hSpace10, icon];
          break;
        case FUIPopupMenuItemIconPosition.left:
        default:
          wList = [icon, FUISpacer.hSpace10, label];
          break;
      }

      itemWidget = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: wList,
      );
    }

    return PopupMenuItem(
      height: FUIPopupMenuTheme.itemHeight,
      value: item.value,
      padding: item.padding ?? FUIPopupMenuTheme.itemPadding,
      enabled: item.enabled,
      onTap: item.onTap,
      child: itemWidget,
    );
  }
}
