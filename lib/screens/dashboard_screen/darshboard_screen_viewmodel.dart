import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:work_together/screens/map_screen/map_screen.dart';
import 'package:work_together/screens/new_place_screen/new_place_screen.dart';

import '../../core/domain/mock_places.dart' as mock_places;
import '../../core/domain/place.dart';

class DashboardScreenViewModel extends ChangeNotifier {
  final places = mock_places.places;
  List<Place> filteredPlaces = [];

  DashboardScreenViewModel() {
    filteredPlaces = places;
  }

  void addPlace() {
    places.add(places[0]);
    notifyListeners();
  }

  Future<void> navigateToMapScreen(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MapScreen()));
  }

  Future<void> navigateToNewPlaceScreen(BuildContext context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NewPlaceScreen()));
  }

  void findPlace(String text) {
    filteredPlaces = places
        .where((place) => place.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    notifyListeners();
  }
}
