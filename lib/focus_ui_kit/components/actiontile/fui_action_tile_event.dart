import 'package:flutter_bloc/flutter_bloc.dart';

class FUIActionTileEvent {
  final bool hover;

  FUIActionTileEvent({
    this.hover = false,
  });
}

class FUIActionTileController extends Cubit<FUIActionTileEvent> {
  FUIActionTileEvent event;

  FUIActionTileController({
    required this.event,
  }) : super(event);

  trigger(FUIActionTileEvent event) {
    this.event = event;
    emit(this.event);
  }
}
