import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
   WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService weatherService = WeatherService('5828d40dfac9d83c351b9b539fbb989a');

  Weather? weather;

  // Fetch data
  fetchWeatherData() async {
    try {
      final wEather = await weatherService.getWeatherDataByCurrentLocation();
      setState(() {
        weather = wEather;
      });
    } catch (e) {
      // Handle the error (e.g., show a snackbar or a message)
      print('Error fetching weather data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

String getWeatherAnimation(String mainContent){
  if (mainContent == null) {
    
return 'lib/assets/01.json';}
switch (mainContent.toLowerCase()) {
  case 'clouds': return 'lib/assets/03.json';
  case 'rain':return 'lib/assets/02.json';
  case 'sunny': return 'lib/assets/01.json';

  default: return 'lib/assets/01.json';
}

}


 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Weather App')),
    body: Center(
      child: weather == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather!.cityName,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${weather!.temperature.round()}°C',
                    style: TextStyle(fontSize: 48),
                  ),
                  SizedBox(height: 20),
                  Text(
                    weather!.mainContent,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Lottie.asset(
                    getWeatherAnimation(weather!.mainContent),
                    // width: 200,
                    // height: 200,
                    // fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
    ),
  );
}

}
