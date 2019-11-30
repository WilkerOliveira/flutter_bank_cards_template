import 'dart:async';

import 'package:bank_cards/src/exceptions/exception_messages.dart';
import 'package:bank_cards/src/models/login.dart';
import 'package:flutter/foundation.dart';

/// Represents the state of the view
enum ViewState { Idle, Busy }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  @protected
  StreamController<ViewState> viewStateController;
  Stream<ViewState> get viewStateStream => this.viewStateController.stream;

  @protected
  bool error;
  @protected
  ExceptionMessages customErrorMessage;

  bool get isError => error;

  ExceptionMessages get errorMessage => customErrorMessage;

  //TODO: mock
  Login _login = Login("12345678909");

  Login get login => this._login;

  //********************************

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setStateStream(ViewState viewState) {
    this.viewStateController.sink.add(viewState);
  }

}
