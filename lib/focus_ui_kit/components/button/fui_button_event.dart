import 'package:flutter_bloc/flutter_bloc.dart';

class FUIButtonEvent {
  bool? enable;

  FUIButtonEvent({
    this.enable,
  });
}

class FUIButtonController extends Cubit<FUIButtonEvent?> {
  FUIButtonEvent? fuiButtonEvent;

  FUIButtonController({
    this.fuiButtonEvent,
  }) : super(fuiButtonEvent);

  trigger(FUIButtonEvent fuiButtonEvent) {
    this.fuiButtonEvent = fuiButtonEvent;
    emit(this.fuiButtonEvent);
  }
}
