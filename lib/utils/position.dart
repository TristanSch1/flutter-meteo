import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  late bool serviceEnabled;
  late LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw 'Service de localisation désactivé';
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Permission de localisation refusée';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'Permission de localisation refusée définitivement, on ne peut pas l\'activer';
  }

  return await Geolocator.getCurrentPosition();
}