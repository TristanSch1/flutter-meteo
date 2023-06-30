class _Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  _Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
}

class _Coord {
  final double lon;
  final double lat;

  _Coord({
    required this.lon,
    required this.lat,
  });
}

class _Main {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final int pressure;
  final int humidity;

  _Main({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
  });
}

class _Wind {
  final double speed;
  final int deg;

  _Wind({
    required this.speed,
    required this.deg,
  });
}

class _Clouds {
  final int all;

  _Clouds({
    required this.all,
  });
}

class _Rain {
  final double? oneHour;
  final double? threeHours;

  _Rain({
    this.oneHour,
    this.threeHours,
  });
}

class _Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  _Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });
}

class WeatherResponse {
  final _Coord coord;
  final List<_Weather> weather;
  final String base;
  final _Main main;
  final int visibility;
  final _Wind wind;
  final _Clouds clouds;
  final _Rain rain;
  final int dt;
  final _Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  WeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.rain,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      coord: _Coord(
        lon: json['coord']['lon'],
        lat: json['coord']['lat'],
      ),
      weather: [
        _Weather(
          id: json['weather'][0]['id'],
          main: json['weather'][0]['main'],
          description: json['weather'][0]['description'],
          icon: json['weather'][0]['icon'],
        )
      ],
      base: json['base'],
      main: _Main(
        temp: json['main']['temp'],
        feels_like: json['main']['feels_like'],
        temp_min: json['main']['temp_min'],
        temp_max: json['main']['temp_max'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
      ),
      visibility: json['visibility'],
      wind: _Wind(
        speed: json['wind']['speed'],
        deg: json['wind']['deg'],
      ),
      clouds: _Clouds(
        all: json['clouds']['all'],
      ),
      rain: _Rain(
        oneHour: json['rain']?['1h'],
        threeHours: json['rain']?['3h'],
      ),
      dt: json['dt'],
      sys: _Sys(
        type: json['sys']['type'],
        id: json['sys']['id'],
        country: json['sys']['country'],
        sunrise: json['sys']['sunrise'],
        sunset: json['sys']['sunset'],
      ),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}