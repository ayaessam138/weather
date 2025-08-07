
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/app_spacing.dart';
import 'package:weather/core/app_values.dart';
import 'package:weather/core/colors.dart';
import 'package:weather/core/styles.dart';
import 'package:weather/features/cityweather/persentation/controller/city_weather_provider.dart';

class CityWeatherScreen extends StatelessWidget {
  CityWeatherScreen({super.key});

  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider()..fetchWeather(),
      child: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600.w),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(AppPadding.p30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 🔍 Search Field
                            TextField(
                              onSubmitted: (value) {
                                final city = cityController.text.trim();
                                if (city.isNotEmpty) {
                                  provider.fetchWeather(city);
                                  FocusScope.of(
                                    context,
                                  ).unfocus(); // hide keyboard
                                  cityController
                                      .clear(); // optional: clear input
                                }
                              },
                              controller: cityController,
                              style: const TextStyle(
                                color: ColorsManager.white,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Enter city',
                                labelStyle: const TextStyle(
                                  color: ColorsManager.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.r12,
                                  ),
                                  borderSide: const BorderSide(
                                    color: ColorsManager.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.r12,
                                  ),
                                  borderSide: const BorderSide(
                                    color: ColorsManager.white,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: ColorsManager.white,
                                  ),
                                  onPressed: () {
                                    final city = cityController.text.trim();
                                    if (city.isNotEmpty) {
                                      provider.fetchWeather(city);
                                    }
                                  },
                                ),
                                filled: true,
                                fillColor: ColorsManager.white.withOpacity(0.1),
                              ),
                            ),

                            AppSpace.vertical(AppHeight.h40),

                            //  Loading State
                            if (provider.isLoading)
                              const CircularProgressIndicator(
                                color: Colors.white,
                              ),

                            //  Error Message
                            if (provider.errorMessage != null)
                              Text(
                                provider.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),

                            //  Weather Info (if available)
                            if (provider.weather != null) ...[
                              AutoSizeText(
                                provider.currentCity, // city name input
                                style: TextStyles.font30SemiBold,
                                maxLines: 1,
                              ),
                              AppSpace.vertical(AppHeight.h10),

                              AutoSizeText(
                                provider.weather!.description,
                                maxLines: 1,
                                style: TextStyles.font16Medium.copyWith(
                                  color: ColorsManager.white.withOpacity(0.5),
                                ),
                              ),
                              AppSpace.vertical(AppHeight.h20),

                              SizedBox(
                                height: 100.h,
                                child: Image.network(
                                  'https://openweathermap.org/img/wn/${provider.weather!.icon}@2x.png',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "asset/images/placeholder.png",
                                    );
                                  },
                                ),
                              ),
                              AppSpace.vertical(AppHeight.h10),

                              AutoSizeText(
                                '${provider.weather!.temperature.toStringAsFixed(1)} °C',
                                style: TextStyles.font20semiBold,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
