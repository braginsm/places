import 'package:flutter/painting.dart';

/// Стили текстов
TextStyle _text = const TextStyle(
  fontFamily: "Roboto",
  fontStyle: FontStyle.normal,
  fontSize: 14
),

//Light
    textLight = _text.copyWith(fontWeight: FontWeight.w300),

//Regular
    textRegular = _text.copyWith(fontWeight: FontWeight.normal),
    textRegular16 = textRegular.copyWith(fontSize: 16.0),

//Medium
    textMedium = _text.copyWith(fontWeight: FontWeight.w500),
    textMedium16 = textMedium.copyWith(fontSize: 16),
//Bold
    textBold = _text.copyWith(fontWeight: FontWeight.w700),
    textBold24 = textBold.copyWith(fontSize: 24),
    textBold32 = textBold.copyWith(fontSize: 32);