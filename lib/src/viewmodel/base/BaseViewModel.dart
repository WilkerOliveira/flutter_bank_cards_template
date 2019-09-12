import 'package:flutter/foundation.dart';

/// Represents the state of the view
enum ViewState { Idle, Busy }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
