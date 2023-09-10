import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:work_together/core/services/file_service.dart';

class MapScreenViewModel extends ChangeNotifier {
  final FileService fileService;

  List<LatLng> _countryPolygon = [];
  List<LatLng> get countryPolygon => _countryPolygon;

  List<LatLng> _cityPolygon = [];
  List<LatLng> get cityPolygon => _cityPolygon;

  final List<Marker> _places = [];
  List<Marker> get places => _places;

  List<LatLng> workPlacesCoordinates = const [
    LatLng(41.9981, 21.4254),
    LatLng(42.019753, 21.435533),
    LatLng(41.992771, 21.419063),
    LatLng(42.004014, 21.395439),
    LatLng(41.993079, 21.443723),
    LatLng(42.012329, 21.445795),
  ];

  Position? currentPosition;
  LatLng currentLocation = const LatLng(41.9981, 21.4254);

  MapScreenViewModel({required this.fileService});

  Future<void> loadDefaultMapData() async {
    final results = await Future.wait([
      fileService.readJsonFromFile('assets/skopje_coordinates.json'),
      fileService.readJsonFromFile('assets/macedonia_coordinates.json')
    ]);

    var cityCoordinates = jsonDecode(results[0])['coordinates'];
    var countryCoordinates = jsonDecode(results[1])['coordinates'];

    _cityPolygon = cityCoordinates
        .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
        .toList();
    _countryPolygon = countryCoordinates
        .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
        .toList();

    loadInitialPlaces();

    notifyListeners();
  }

  void loadInitialPlaces() {
    for (LatLng coord in workPlacesCoordinates) {
      Marker marker = Marker(
        width: 30.0,
        height: 30.0,
        point: coord,
        builder: (ctx) => SvgPicture.asset(
          'assets/coffee.svg',
          width: 30,
          height: 30,
        ),
      );

      _places.add(marker);
    }
  }

  Future<void> navigateBack(BuildContext context) async {
    Navigator.of(context).pop();
  }

  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // currentPosition = position;
      currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
