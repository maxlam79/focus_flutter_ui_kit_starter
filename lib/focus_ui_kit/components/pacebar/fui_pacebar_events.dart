import 'package:flutter_bloc/flutter_bloc.dart';

class FUIPaceBarControlEvent {
  final bool? barShow;
  final double? barValue;

  FUIPaceBarControlEvent({
    this.barShow,
    this.barValue,
  });
}

class FUIPaceBarController extends Cubit<FUIPaceBarControlEvent?> {
  FUIPaceBarControlEvent? event;

  FUIPaceBarController({
    this.event,
  }) : super(event);

  trigger(FUIPaceBarControlEvent event) {
    this.event = event;
    emit(this.event);
  }
}
