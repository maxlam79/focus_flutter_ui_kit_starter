import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIMenuItem extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final List<FUISubMenuItem>? fuiSubMenuItems;
  final Widget label;
  final Widget? icon;
  final bool selected;
  final Widget? selectedLabel;
  final Widget? selectedIcon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;
  final ValueChanged<bool>? onHover;

  FUIMenuItem({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiSubMenuItems,
    required this.label,
    this.icon,
    this.selected = false,
    this.selectedLabel,
    this.selectedIcon,
    required this.onPressed,
    this.onLongPressed,
    this.onHover,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIMenuItem> createState() => _FUIMenuItemState();
}

class _FUIMenuItemState extends State<FUIMenuItem> with FUIColorMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUIMenuTheme fuiMenuTheme;

  /// Flags and Attributes
  late bool isSelected;

  @override
  void initState() {
    super.initState();

    isSelected = widget.selected;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiMenuTheme = context.theme.fuiMenu;

    FUIExpMenuController menuCtrl = context.read<FUIExpMenuController>();

    return BlocBuilder<FUIExpMenuController, FUIExpMenuEvent?>(
      bloc: menuCtrl,
      builder: (BuildContext context, FUIExpMenuEvent? event) {
        if (event != null) {
          if (event.selectedMenuKey != null && widget.key != null) {
            isSelected = (event.selectedMenuKey! == widget.key!);
          }
        }

        Widget label;
        Widget icon;
        Widget ic = const SizedBox(width: FUIMenuTheme.subMenuIconWidth);

        if (isSelected) {
          label = DefaultTextStyle(
            style: _generateLabelTextStyle(context, isSelected),
            child: widget.selectedLabel ?? widget.label,
          );

          if (widget.selectedIcon != null) {
            ic = widget.selectedIcon!;
          } else if (widget.icon != null) {
            ic = widget.icon!;
          }

          icon = IconTheme.merge(
              data: IconThemeData(
                color: _discernSelectedColor(context, isSelected),
                size: FUIMenuTheme.menuItemIconWidth,
              ),
              child: ic);
        } else {
          label = DefaultTextStyle(
            style: _generateLabelTextStyle(context, isSelected),
            child: widget.label,
          );

          if (widget.icon != null) {
            ic = widget.icon!;
          }

          icon = IconTheme.merge(
              data: IconThemeData(
                color: _discernSelectedColor(context, isSelected),
                size: FUIMenuTheme.menuItemIconWidth,
              ),
              child: ic);
        }

        return Container(
          margin: const EdgeInsets.only(left: FUIMenuTheme.menuItemMarginLeft, top: FUIMenuTheme.menuItemMarginTop),
          height: FUIMenuTheme.menuItemHeight,
          child: GestureDetector(
            onTap: () {
              menuCtrl.trigger(
                FUIExpMenuEvent(
                  selectedMenuKey: widget.key,
                ),
              );

              widget.onPressed();
                        },
            onLongPress: widget.onLongPressed,
            child: MouseRegion(
              onHover: (_) => widget.onHover,
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  // Icon Container
                  Container(
                    alignment: Alignment.centerLeft,
                    child: icon,
                  ),
                  // Menu Item Text Container
                  Container(
                    margin: const EdgeInsets.only(left: FUIMenuTheme.menuItemTextIconSpace),
                    alignment: Alignment.centerLeft,
                    child: label,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _discernSelectedColor(BuildContext context, bool selected) {
    Color color = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);

    if (selected) {
      return color;
    } else {
      return fuiMenuTheme.mainMenuMainCatText.color!;
    }
  }

  TextStyle _generateLabelTextStyle(BuildContext context, bool selected) {
    return selected
        ? fuiMenuTheme.mainMenuMainCatTextSelected.copyWith(
            color: _discernSelectedColor(context, selected),
          )
        : fuiMenuTheme.mainMenuMainCatText;
  }
}
