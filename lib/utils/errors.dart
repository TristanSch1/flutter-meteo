class CityErrors {
  static const String error = 'Erreur lors de la récupération de la ville';
  static const String notFound = 'Ville non trouvée';
}

class WeatherErrors {
  static const String error = 'Erreur lors de la récupération de la météo';
  static const String notFound = 'Météo non trouvée pour cette ville';
}

enum ErrorType {
  CITY,
  WEATHER,
}

class CustomError extends Error {
  final String message;
  final ErrorType type;

  CustomError(this.message, this.type);

  @override
  String toString() {
    return message;
  }
}

class CityError extends CustomError {
  CityError(String message) : super(message, ErrorType.CITY);
}

class WeatherError extends CustomError {
  WeatherError(String message) : super(message, ErrorType.WEATHER);
}

void throwCustomError(String message, ErrorType type) {
  switch (type) {
    case ErrorType.CITY:
      throw CityError(message);
    case ErrorType.WEATHER:
      throw WeatherError(message);
  }
}