import 'package:flutter_bloc/flutter_bloc.dart';

class FUIPaneControlEvent {
  final bool? enable;
  final bool? blur;
  final bool? spinnerShow;
  final bool? paceBarShow;
  final double? paceBarValue;

  const FUIPaneControlEvent({
    this.enable,
    this.blur,
    this.spinnerShow,
    this.paceBarShow,
    this.paceBarValue,
  });
}

class FUIPaneController extends Cubit<FUIPaneControlEvent?> {
  FUIPaneControlEvent? event;

  FUIPaneController({
    this.event,
  }) : super(event);

  trigger(FUIPaneControlEvent event) {
    this.event = event;
    emit(event);
  }
}
