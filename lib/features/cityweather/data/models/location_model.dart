class LocationModel {
  final double lat;
  final double lon;

  LocationModel({required this.lat, required this.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(lat: json['lat'], lon: json['lon']);
  }
}