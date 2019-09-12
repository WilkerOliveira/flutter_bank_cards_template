import 'package:bank_cards/src/models/card/login.dart';
import 'package:flutter/foundation.dart';

/// Represents the state of the view
enum ViewState { Idle, Busy }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  //TODO: mock
  Login _login = Login("12345678909");
  Login get login => this._login;
  //********************************

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
