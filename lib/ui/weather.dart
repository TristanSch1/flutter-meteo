import 'package:flutter/material.dart';
import 'package:meteo/models/city.dart';
import 'package:meteo/models/weather.dart';
import 'package:meteo/utils/fetchers.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key, required this.cityName}) : super(key: key);

  final String cityName;

  Future<WeatherResponse> getWeatherResponse () async {
    City city = await getCity(cityName);
    WeatherResponse weatherResponse = await getWeather(city.latitude, city.longitude);

    return weatherResponse;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeatherResponse(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          WeatherResponse weatherResponse = snapshot.data as WeatherResponse;

          return Scaffold(
            appBar: AppBar(
              title: Text('Meteo à ${weatherResponse.name}'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('https://openweathermap.org/img/wn/${weatherResponse.weather[0].icon}@2x.png'),
                  Text(weatherResponse.weather[0].description, style: const TextStyle(color: Colors.black87, fontSize: 24)),
                  const SizedBox(height: 16),
                  Text('${weatherResponse.main.temp}°C', style: const TextStyle(color: Colors.grey, fontSize: 20)),
                ],
              ),
            ),
          );
        }

        if(snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Meteo'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.error.toString(), style: const TextStyle(color: Colors.grey, fontSize: 24)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Retour'),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}