import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/cityweather/persentation/ui/city_weather_screen.dart';

void main() => runApp(
  DevicePreview(enabled: false, builder: (context) => MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,

          home: child,
        );
      },
      child: CityWeatherScreen(),
    );
  }
}
