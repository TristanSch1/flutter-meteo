class City {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final int population;
  final bool is_capital;

  City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.population,
    required this.is_capital,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      country: json['country'],
      population: json['population'],
      is_capital: json['is_capital'],
    );
  }
}