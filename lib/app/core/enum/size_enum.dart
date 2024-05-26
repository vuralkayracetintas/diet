import 'package:flutter/material.dart';

/// Project Size Enum
///
enum SizeEnum {
  /// Size value 5
  xSmall(5),

  /// Size value 10
  small(10),

  /// Size value 15
  medium(15),

  /// Size value =20
  large(20),

  /// Size value 25
  xLarge(25);

  final double value;
  const SizeEnum(this.value);

  /// SizedBox All
  SizedBox get all => SizedBox(height: value, width: value);

  /// SizedBox only height
  SizedBox get onlyHeight => SizedBox(height: value);

  /// SizedBox only width
  SizedBox get onlyWidth => SizedBox(width: value);
}
