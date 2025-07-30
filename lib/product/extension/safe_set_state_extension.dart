import 'package:flutter/material.dart';

mixin SafeSetStateMixin<T extends StatefulWidget> on State<T> {
  void safeSetState(VoidCallback callback) {
    if (mounted) {
      setState(callback);
    }
  }
}
