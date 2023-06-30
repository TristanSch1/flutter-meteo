import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meteo/models/city.dart';
import 'package:dio/dio.dart';
import 'package:meteo/models/weather.dart';
import 'package:meteo/utils/errors.dart';

final dio = Dio();

String cityApiUrl (String cityName) => 'https://api.api-ninjas.com/v1/city?name=$cityName';
String weatherApiUrl (double lat, double lon) {
  String? apiKey = dotenv.env['METEO_API_KEY'];
  String query = 'lat=$lat&lon=$lon&units=metric&appid=$apiKey&lang=fr';
  return 'https://api.openweathermap.org/data/2.5/weather?$query';
}


Future<City> getCity (String cityName) async {
  Response<List<dynamic>> response;
    response = await dio.get<List<dynamic>>(
      cityApiUrl(cityName),
      options: Options(headers: { 'X-Api-Key': dotenv.env['CITY_API_KEY'] }),
    );

    if(response.statusCode != 200) {
      throwCustomError(CityErrors.error, ErrorType.CITY);
    }

    if(response.data == null) {
      throwCustomError(CityErrors.notFound, ErrorType.CITY);
    }

    if(response.data!.isEmpty) {
      throwCustomError(CityErrors.notFound, ErrorType.CITY);
    }

    return City.fromJson(response.data![0]);
}

Future<WeatherResponse> getWeather (double lat, double lon) async {
  Response<Map<String, dynamic>> response;
    response = await dio.get<Map<String, dynamic>>(
      weatherApiUrl(lat, lon),
    );

    if (response.statusCode != 200) {
      throwCustomError(WeatherErrors.error, ErrorType.WEATHER);
    }

    if (response.data == null) {
      throwCustomError(WeatherErrors.notFound, ErrorType.WEATHER);
    }

    return WeatherResponse.fromJson(response.data!);
}
