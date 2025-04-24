import 'package:flutter_bloc/flutter_bloc.dart';

class FUIPanelControlEvent {
  final bool? enable;
  final bool? blur;
  final bool? spinnerShow;
  final bool? paceBarShow;
  final double? paceBarValue;

  FUIPanelControlEvent({
    this.enable,
    this.blur,
    this.spinnerShow,
    this.paceBarShow,
    this.paceBarValue,
  });
}

class FUIPanelController extends Cubit<FUIPanelControlEvent?> {
  FUIPanelControlEvent? event;

  FUIPanelController({
    this.event,
  }) : super(event);

  trigger(FUIPanelControlEvent event) {
    this.event = event;
    emit(event);
  }
}
