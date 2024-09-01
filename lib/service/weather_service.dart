import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  // Get data from the server using the city name
  Future<Weather> getWeatherDataByCityName(String cityName) async {
    // Get the response
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    // If response is successful, convert the JSON data into a Dart object using the fromMap method
    if (response.statusCode == 200) {
      return Weather.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Get data from the server using coordinates
  Future<Weather> getWeatherDataByCoordinates(double latitude, double longitude) async {
    // Get the response
    final response = await http.get(Uri.parse('$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    // If response is successful, convert the JSON data into a Dart object using the fromMap method
    if (response.statusCode == 200) {
      return Weather.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Get the city name using the current location
  Future<String> getCityName() async {
    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get the position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get the placemark
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Extract the city name
    final cityName = placemarks[0].locality;
    return cityName ?? 'unknown';
  }

  // Get weather data using the current location
  Future<Weather> getWeatherDataByCurrentLocation() async {
    // Get the position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Fetch the weather data using coordinates
    return await getWeatherDataByCoordinates(position.latitude, position.longitude);
  }
}
