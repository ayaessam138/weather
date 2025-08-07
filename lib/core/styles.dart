import 'package:flutter/material.dart';
import 'package:weather/core/app_values.dart';
import 'package:weather/core/colors.dart';

import 'font_weight_helper.dart';

class TextStyles {
  static const String _fontFamily = "Airbnb Cereal App";

  static TextStyle font30SemiBold = TextStyle(
    color: ColorsManager.white,
    fontSize: AppFontSize.f30,
    fontWeight: FontWeightHelper.semiBold,
    fontFamily: _fontFamily,
  );

  static TextStyle font20semiBold = TextStyle(
    color: ColorsManager.white,
    fontSize: AppFontSize.f20,
    fontWeight: FontWeightHelper.semiBold,
    fontFamily: _fontFamily,
  );
  static TextStyle font16Medium = TextStyle(
    color: ColorsManager.white,
    fontSize: AppFontSize.f16,
    fontWeight: FontWeightHelper.medium,
    fontFamily: _fontFamily,
  );
}
