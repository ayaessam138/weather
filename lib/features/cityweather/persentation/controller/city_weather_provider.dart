import 'package:flutter/material.dart';
import 'package:weather/features/cityweather/data/api/weather_api.dart';
import 'package:weather/features/cityweather/data/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherApi _api = WeatherApi();

  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;
  String _currentCity = "Cairo"; 

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get currentCity => _currentCity; 

  Future<void> fetchWeather([String? city]) async {
    _isLoading = true;
     _weather = null;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _api.fetchWeather(city);
      _currentCity = (city == null || city.trim().isEmpty) ? 'Cairo' : city.trim(); 
    } catch (e) {
      _errorMessage = "حدث خطأ أثناء جلب البيانات";
       _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
