import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/core/consts.dart';
import 'package:weather/core/http_helper.dart';
import 'package:weather/features/cityweather/data/models/location_model.dart';
import 'package:weather/features/cityweather/data/models/weather_model.dart';

class WeatherApi {
  final HttpClient _httpClient = HttpClient();

  Future<WeatherModel> fetchWeather(String? city) async {
    try {
      final location = await fetchGeoLocation(city);

      final response = await _httpClient.get(
        '/weather',
        baseUrl: defaultBaseUrl,
        queryParams: {
          'lat': location.lat.toString(),
          'lon': location.lon.toString(),
          'appid': openWeatherApiKey,
          'units': 'metric',
        },
      );

      final json = jsonDecode(response.body);
      print(response.body);
      return WeatherModel.fromJson(json);
    } catch (e) {
      print("Fetch weather error: $e");
      rethrow;
    }
  }

  Future<LocationModel> fetchGeoLocation(String? city) async {
    final cityName = (city == null || city.trim().isEmpty)
        ? 'Cairo'
        : city.trim();

    final response = await _httpClient.get(
      '/direct',
      baseUrl: geoBaseUrl,
      queryParams: {
        'q': cityName,
        'limit': '1',
        'appid': openWeatherApiKey,
      },
    );

      print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        return LocationModel.fromJson(data[0]);
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('Failed to fetch geo location');
    }
  }
}
