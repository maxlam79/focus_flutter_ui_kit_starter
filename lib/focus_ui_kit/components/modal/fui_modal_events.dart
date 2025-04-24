import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modals/modals.dart';

import '../../exports.dart';

class FUIModalControlEvent {
  final bool? enable;
  final bool? blur;
  final bool? spinnerShow;
  final bool? paceBarShow;
  final double? paceBarValue;
  final bool? close;

  FUIModalControlEvent({
    this.enable,
    this.blur,
    this.spinnerShow,
    this.paceBarShow,
    this.paceBarValue,
    this.close,
  });
}

class FUIModalController extends Cubit<FUIModalControlEvent?> {
  FUIModalControlEvent? event;

  FUIModalController({
    this.event,
  }) : super(event);

  trigger(FUIModalControlEvent event) {
    this.event = event;
    emit(event);
  }

  static showFUIModal(
    BuildContext context, {
    required Widget modal,
  }) {
    FUIModalTheme fuiModalTheme = context.theme.fuiModal;

    showModal(ModalEntry.aligned(
      context,
      tag: 'FUIModal',
      alignment: Alignment.center,
      barrierDismissible: true,
      barrierColor: fuiModalTheme.barrierColor,
      child: modal,
    ));
  }

  static showFUIModalByModalEntry(ModalEntry modalEntry) {
    showModal(modalEntry);
  }
}
