import 'package:flutter/painting.dart';

/// Стили текстов
class TextStyleSet {
  /// Поуолчаию
  TextStyle _text = const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 14
  );

  ///Light
  TextStyle get textLight => _text.copyWith(fontWeight: FontWeight.w300);

  ///Regular
  TextStyle get textRegular => _text.copyWith(fontWeight: FontWeight.normal);
  TextStyle get textRegular16 => textRegular.copyWith(fontSize: 16);
  TextStyle get textRegular12 => textRegular.copyWith(fontSize: 12);

  ///Medium
  TextStyle get textMedium => _text.copyWith(fontWeight: FontWeight.w500);
  TextStyle get textMedium16 => textMedium.copyWith(fontSize: 16);
  TextStyle get textMedium18 => textMedium.copyWith(fontSize: 18);

  ///Bold
  TextStyle get textBold => _text.copyWith(fontWeight: FontWeight.w700);
  TextStyle get textBold24 => textBold.copyWith(fontSize: 24);
  TextStyle get textBold32 => textBold.copyWith(fontSize: 32);
}
