import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FUIExpMenuEvent {
  Key? selectedMenuKey;
  Key? selectedSubMenuKey;

  FUIExpMenuEvent({
    this.selectedMenuKey,
    this.selectedSubMenuKey,
  });
}

class FUIExpMenuController extends Cubit<FUIExpMenuEvent?> {
  FUIExpMenuEvent? event;
  Key? _lastMenuItemKey;
  Key? _lastSubMenuItemKey;

  FUIExpMenuController({this.event}) : super(event);

  trigger(FUIExpMenuEvent? event) {
    this.event = event;

    if (this.event?.selectedMenuKey != null) {
      _lastMenuItemKey = this.event?.selectedMenuKey;
    }

    if (this.event?.selectedSubMenuKey != null) {
      _lastSubMenuItemKey = this.event?.selectedSubMenuKey;
    }

    emit(event);
  }

  Key? get lastMenuItemKey => _lastMenuItemKey;

  Key? get lastSubMenuItemKey => _lastSubMenuItemKey;
}
