import 'package:flutter/material.dart';

enum _ViewState { ideal, busy }

class BaseProvider extends ChangeNotifier {
  _ViewState _viewState = _ViewState.ideal;

  bool get isBusy => _viewState == _ViewState.busy;

  void setViewBusy({
    bool notify = true,
  }) {
    if (notify) {
      _viewState = _ViewState.busy;
      notifyListeners();
    }
  }

  void setViewIdeal({
    bool notify = true,
  }) {
    if (notify) {
      _viewState = _ViewState.ideal;
      notifyListeners();
    }
  }
}
