import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo/ui/weather.dart';
import 'package:meteo/utils/fetchers.dart';
import 'package:meteo/utils/position.dart';

class Meteo extends StatefulWidget {
  const Meteo({Key? key}) : super(key: key);

  @override
  State<Meteo> createState() => _Meteo();
}

class _Meteo extends State<Meteo> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sunny, size: 100, color: Colors.amber),
              const SizedBox(height: 32),
              const Text('Flutter Meteo', style: TextStyle(color: Colors.blueGrey, fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              SearchBar(
                hintText: 'Entrez une ville',
                onChanged: (value) {
                  setState(() {
                    cityName = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Weather()));
                },
                icon: const Icon(Icons.my_location, color: Colors.blueGrey),
                tooltip: 'Utiliser ma position',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (cityName.isEmpty) {
                    SnackBar snackBar = const SnackBar(content: Text('Le champ ne peut pas être vide'), backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Weather(cityName: cityName,)));
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                ),
                child: const Text('Rechercher'),
              ),
            ],
          )
        )
      ),
    );
  }
}