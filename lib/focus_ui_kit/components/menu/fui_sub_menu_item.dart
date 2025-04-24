import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUISubMenuItem extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final Widget label;
  final Widget? icon;
  final bool selected;
  final Widget? selectedLabel;
  final Widget? selectedIcon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;
  final ValueChanged<bool>? onHover;

  FUISubMenuItem({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
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
  State<FUISubMenuItem> createState() => _FUISubMenuItemState();
}

class _FUISubMenuItemState extends State<FUISubMenuItem> with FUIColorMixin {
  /// Bloc
  late FUIExpMenuController menuCtrl;

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
          if (event.selectedSubMenuKey != null && widget.key != null) {
            isSelected = (event.selectedSubMenuKey! == widget.key!);
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
                size: FUIMenuTheme.subMenuIconWidth,
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
                size: FUIMenuTheme.subMenuIconWidth,
              ),
              child: ic);
        }

        return Container(
          margin: const EdgeInsets.only(left: FUIMenuTheme.subMenuItemMarginLeft),
          height: FUIMenuTheme.subMenuItemHeight,
          child: GestureDetector(
            onTap: () {
              menuCtrl.trigger(
                FUIExpMenuEvent(
                  selectedSubMenuKey: widget.key,
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
                  icon,
                  // Menu Item Text Container
                  Container(
                    margin: const EdgeInsets.only(left: FUIMenuTheme.subMenuItemTextIconSpace),
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
      return fuiMenuTheme.mainMenuSubCatText.color!;
    }
  }

  TextStyle _generateLabelTextStyle(BuildContext context, bool selected) {
    return selected
        ? fuiMenuTheme.mainMenuSubCatTextSelected.copyWith(
            color: _discernSelectedColor(context, selected),
          )
        : fuiMenuTheme.mainMenuSubCatText;
  }
}
