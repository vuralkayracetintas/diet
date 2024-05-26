import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Navigation Helper [Class]
class Navigation {
  Navigation._();

  /// Navigation Global Key
  static GlobalKey<NavigatorState> navigationKey = GlobalKey();

  /// Navigation Push [Function]
  static Future<T?>? push<T>({required Widget page}) =>
      navigationKey.currentState?.push(materialPageRoute(page));

  /// Navigation of pop [Function]
  static void ofPop() => navigationKey.currentState?.pop();

  /// Navigation Push and Remove All Function

  static Future<T?>? pushAndRemoveAll<T>({required Widget page}) =>
      navigationKey.currentState
          ?.pushAndRemoveUntil(materialPageRoute(page), (route) => false);

  /// Navigation Push Replace [Function]
  static Future<T?>? pushReplace<T>({required Widget page}) =>
      navigationKey.currentState?.pushReplacement(materialPageRoute(page));

  /// Navigation Push Named and Remove All [Function]
  static Future<T?>? pushNamedAndRemoveAll<T>(
          {required String root, Object? arg}) =>
      navigationKey.currentState
          ?.pushNamedAndRemoveUntil(root, (route) => false, arguments: arg);

  /// Navigation Push Replacement Named [Function]
  static Future<T?>? pushReplacementNamed<T>({required String root}) =>
      navigationKey.currentState?.pushReplacementNamed(root);

  /// Navigation Material Page Route
  static MaterialPageRoute<T> materialPageRoute<T>(Widget page) =>
      MaterialPageRoute(builder: (context) => page);
}
