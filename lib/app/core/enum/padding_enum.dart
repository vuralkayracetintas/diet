import 'package:flutter/material.dart';

/// Padding Enum
enum PaddingEnum {
  /// Padding Value Small
  small(15),

  /// Padding Value medium
  medium(20),

  /// Padding Value large
  large(25),

  /// Padding Value xLarge
  xLarge(30);

  /// value
  final double value;

  const PaddingEnum(this.value);

  /// Padding All
  EdgeInsets get all => EdgeInsets.all(value);

  /// Padding symmetric
  EdgeInsets get symmetric =>
      EdgeInsets.symmetric(horizontal: value, vertical: value);

  /// Padding only
  EdgeInsets get onlyPadding =>
      EdgeInsets.only(left: value, right: value, top: value, bottom: value);
}
