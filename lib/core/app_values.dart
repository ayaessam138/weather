import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHeight {
  static double fullHight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
  static double h40 = 40.h;
  static double h20 = 20.h;
  static double h10 = 10.h;
}

class AppWidth {
  static double fullWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double w100 = 100.w;
}

class AppFontSize {
  static final f30 = 30.sp;
  static final f20 = 20.sp;
  static final f16 = 16.sp;
}

class AppPadding {
  static final p30 = 30.r;
  static final p20 = 20.r;
}

class AppRadius {
  static final rDefault = 4.r;
  static final r12 = 12.r;
}
