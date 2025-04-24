import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

enum FUIToastIconPosition {
  left,
  right,
}

enum FUIToastDecoBarPosition {
  top,
  bottom,
  left,
  right,
  none,
}

class FUIToastPosition extends ToastPosition {
  const FUIToastPosition({super.align = Alignment.center, super.offset = 0.0});

  static const FUIToastPosition top = FUIToastPosition(align: Alignment.topCenter, offset: 75.0);
  static const FUIToastPosition topLeft = FUIToastPosition(align: Alignment.topLeft, offset: 75.0);
  static const FUIToastPosition topRight = FUIToastPosition(align: Alignment.topRight, offset: 75.0);
  static const FUIToastPosition center = FUIToastPosition();
  static const FUIToastPosition centerLeft = FUIToastPosition(align: Alignment.centerLeft, offset: 0.0);
  static const FUIToastPosition centerRight = FUIToastPosition(align: Alignment.centerRight, offset: 0.0);
  static const FUIToastPosition bottom = FUIToastPosition(align: Alignment.bottomCenter, offset: -30.0);
  static const FUIToastPosition bottomLeft = FUIToastPosition(align: Alignment.bottomLeft, offset: -30.0);
  static const FUIToastPosition bottomRight = FUIToastPosition(align: Alignment.bottomRight, offset: -30.0);

  String toNameString() {
    if (align == Alignment.topCenter) {
      return 'top';
    } else if (align == Alignment.topLeft) {
      return 'topLeft';
    } else if (align == Alignment.topRight) {
      return 'topRight';
    } else if (align == Alignment.center) {
      return 'center';
    } else if (align == Alignment.centerLeft) {
      return 'centerLeft';
    } else if (align == Alignment.centerRight) {
      return 'centerRight';
    } else if (align == Alignment.bottomCenter) {
      return 'bottom';
    } else if (align == Alignment.bottomLeft) {
      return 'bottomLeft';
    } else if (align == Alignment.bottomRight) {
      return 'bottomRight';
    } else {
      return '';
    }
  }

  String toTitleString() {
    if (align == Alignment.topCenter) {
      return 'Top';
    } else if (align == Alignment.topLeft) {
      return 'Top Left';
    } else if (align == Alignment.topRight) {
      return 'Top Right';
    } else if (align == Alignment.center) {
      return 'Center';
    } else if (align == Alignment.centerLeft) {
      return 'Center Left';
    } else if (align == Alignment.centerRight) {
      return 'Center Right';
    } else if (align == Alignment.bottomCenter) {
      return 'Bottom';
    } else if (align == Alignment.bottomLeft) {
      return 'Bottom Left';
    } else if (align == Alignment.bottomRight) {
      return 'Bottom Right';
    } else {
      return '';
    }
  }

  static FUIToastPosition parseName(String name) {
    switch (name) {
      case 'top':
        return FUIToastPosition.top;
      case 'topLeft':
        return FUIToastPosition.topLeft;
      case 'topRight':
        return FUIToastPosition.topRight;
      case 'center':
        return FUIToastPosition.center;
      case 'centerLeft':
        return FUIToastPosition.centerLeft;
      case 'centerRight':
        return FUIToastPosition.centerRight;
      case 'bottom':
        return FUIToastPosition.bottom;
      case 'bottomLeft':
        return FUIToastPosition.bottomLeft;
      case 'bottomRight':
        return FUIToastPosition.bottomRight;
      default:
        return FUIToastPosition.top;
    }
  }
}
