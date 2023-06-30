import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meteo/models/city.dart';
import 'package:meteo/models/weather.dart';
import 'package:meteo/ui/weather.dart';
import 'package:meteo/utils/fetchers.dart';

class Meteo extends StatefulWidget {
  const Meteo({Key? key}) : super(key: key);

  @override
  State<Meteo> createState() => _Meteo();
}

class _Meteo extends State<Meteo> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBar(
                hintText: 'Search city',
                onChanged: (value) {
                  setState(() {
                    cityName = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Weather(cityName: cityName)));
                },
                child: const Text('Search'),
              ),
            ],
          )
        )
      ),
    );
  }
}