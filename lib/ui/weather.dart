import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meteo/models/city.dart';
import 'package:meteo/models/weather.dart';
import 'package:meteo/utils/fetchers.dart';
import 'package:meteo/utils/position.dart';

class Weather extends StatelessWidget {
  Weather({Key? key, this.cityName}) : super(key: key);

  late String? cityName;

  Future<WeatherResponse> getWeatherWithCityName (String cityName) async {
    City city = await getCity(cityName);
    WeatherResponse weatherResponse = await getWeather(city.latitude, city.longitude);

    return weatherResponse;
  }

  Future<WeatherResponse> getWeatherWithPosition () async {
    Position position = await determinePosition();
    WeatherResponse weatherResponse = await getWeather(position.latitude, position.longitude);

    return weatherResponse;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cityName != null ? getWeatherWithCityName(cityName!) : getWeatherWithPosition(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          WeatherResponse weatherResponse = snapshot.data as WeatherResponse;

          return Scaffold(
            appBar: AppBar(
              title: Text('Meteo à ${weatherResponse.name}', style: const TextStyle(color: Colors.blueGrey)),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network('https://openweathermap.org/img/wn/${weatherResponse.weather[0].icon}@2x.png'),
                    Text(
                        weatherResponse.weather[0].description[0].toUpperCase() + weatherResponse.weather[0].description.substring(1).toLowerCase(),
                        style: const TextStyle(color: Colors.blueGrey, fontSize: 24)
                    ),
                    const SizedBox(height: 24),
                    Text('${weatherResponse.main.temp}°C', style: const TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey, width: 3),
                        ),
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(weatherResponse.coord.lat, weatherResponse.coord.lon),
                              zoom: 13,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 48.0,
                                    height: 48.0,
                                    point: LatLng(weatherResponse.coord.lat, weatherResponse.coord.lon),
                                    builder: (ctx) =>
                                    const Icon(
                                      Icons.location_pin,
                                      color: Colors.blue,
                                      size: 48,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )

                    )
                  ],
                ),
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