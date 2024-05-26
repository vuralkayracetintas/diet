import 'package:flutter/material.dart';

/// Padding Extension
extension PaddingExtension on Widget {
  ///  Padding All
  Widget allPadding(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  /// Padding symmetric
  Widget paddingSymmetric({
    double vertical = 0,
    double horizontal = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Padding Only

  Widget onlyPadding({
    double bottom = 0,
    double top = 0,
    double right = 0,
    double left = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }
}
