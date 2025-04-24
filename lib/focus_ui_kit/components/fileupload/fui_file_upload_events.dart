import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FUIFUItemEvent {
  final bool? enable;
  final bool? blur;
  final bool? spinnerShow;
  final bool? paceBarShow;
  final double? paceBarValue;
  final Widget? descLine1;
  final Widget? descLine2;
  final Widget? descLine3;

  const FUIFUItemEvent({
    this.enable,
    this.blur,
    this.spinnerShow,
    this.paceBarShow,
    this.paceBarValue,
    this.descLine1,
    this.descLine2,
    this.descLine3,
  });
}

class FUIFUItemController extends Cubit<FUIFUItemEvent?> {
  FUIFUItemEvent? event;

  FUIFUItemController({
    this.event,
  }) : super(event);

  trigger(FUIFUItemEvent event) {
    this.event = event;
    emit(event);
  }
}
