import 'package:flutter/material.dart';

class CursorProvider extends ChangeNotifier {
  Offset _position = Offset.zero;
  bool _isHoveringInteractive = false;
  bool _showCursor = false;

  Offset get position => _position;
  bool get isHoveringInteractive => _isHoveringInteractive;
  bool get showCursor => _showCursor;

  void updatePosition(Offset pos) {
    _position = pos;
    _showCursor = true;
    notifyListeners();
  }

  void setHovering(bool val) {
    if (_isHoveringInteractive != val) {
      _isHoveringInteractive = val;
      notifyListeners();
    }
  }

  void hideCursor() {
    if (_showCursor) {
      _showCursor = false;
      notifyListeners();
    }
  }
}
