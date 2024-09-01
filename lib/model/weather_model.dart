class Weather {
  final String cityName;
  final double temperature;
  final String mainContent;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainContent,
  });

  factory Weather.fromMap(Map<String,dynamic> json){

  return Weather(
    cityName: json['name'] ?? 'unknown', 
    temperature: (json['main']['temp'] as num).toDouble(), 
    mainContent: json['weather'][0]['main'] ?? 'unknown',
    
    );

  }
} 