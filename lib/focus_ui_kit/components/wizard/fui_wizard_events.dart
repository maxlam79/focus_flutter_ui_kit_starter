import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FUIWizardPageItemSelectEvent {
  final Key selectedWizardItemKey;

  FUIWizardPageItemSelectEvent({
    required this.selectedWizardItemKey,
  });
}

class FUIWizardPageItemSelectController extends Cubit<FUIWizardPageItemSelectEvent?> {
  FUIWizardPageItemSelectEvent? event;

  FUIWizardPageItemSelectController({
    this.event,
  }) : super(event);

  trigger(FUIWizardPageItemSelectEvent? event) {
    this.event = event;
    emit(event);
  }
}

class FUIWizardPaneEvent {
  final bool? prevPage;
  final bool? nextPage;
  final int? gotoPageIdx;
  final Key? gotoPageItemKey;

  FUIWizardPaneEvent({
    this.prevPage,
    this.nextPage,
    this.gotoPageIdx,
    this.gotoPageItemKey,
  });
}

class FUIWizardPaneController extends Cubit<FUIWizardPaneEvent?> {
  FUIWizardPaneController() : super(null);

  nextPage() {
    emit(FUIWizardPaneEvent(nextPage: true));
  }

  prevPage() {
    emit(FUIWizardPaneEvent(prevPage: true));
  }

  gotoPage(int pageIndex) {
    emit(FUIWizardPaneEvent(gotoPageIdx: pageIndex));
  }

  gotoPageItemKey(Key pageItemKey) {
    emit(FUIWizardPaneEvent(gotoPageItemKey: pageItemKey));
  }
}
