import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_together/screens/map_screen/map_screen_viewmodel.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;
  List<LatLng> _polylinePoints = [];

  @override
  void initState() {
    super.initState();

    final viewModel = context.read<MapScreenViewModel>();
    viewModel.addListener((update));

    _mapController = MapController();

    viewModel.loadDefaultMapData();
  }

  void update() => setState(() {});

  Future<void> drawRoute(LatLng tappedLocation) async {
    final userLocation = context.read<MapScreenViewModel>().currentLocation;

    var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/${userLocation.longitude},${userLocation.latitude};${tappedLocation.longitude},${tappedLocation.latitude}?steps=true&annotations=true&geometries=geojson');
    var response = await http.get(url);
    var routeBetweenPoints =
        jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];

    List<LatLng> polylines = [];

    for (int i = 0; i < routeBetweenPoints.length; i++) {
      final location = routeBetweenPoints[i];
      final coordinates = LatLng(location[1], location[0]);
      polylines.add(coordinates);
    }

    setState(
      () {
        _polylinePoints = polylines;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            "Map",
            style: TextStyle(color: Colors.white),
          ),
          leading: InkWell(
            onTap: () {
              context.read<MapScreenViewModel>().navigateBack(context);
            },
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(
                center: const LatLng(41.9981, 21.4254),
                onTap: (tapPosition, point) async {
                  await drawRoute(point);
                },
              ),
              nonRotatedChildren: [
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright'),
                      ),
                    ),
                  ],
                ),
                TileLayer(
                  urlTemplate: 'http://192.168.0.104:8080/tile/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: context.read<MapScreenViewModel>().countryPolygon,
                      color: Colors.grey.withOpacity(0.6),
                      borderStrokeWidth: 3,
                      holePointsList: [
                        context.read<MapScreenViewModel>().cityPolygon
                      ],
                      borderColor: Colors.blue,
                      isFilled: true,
                    ),
                  ],
                ),
                MarkerLayer(markers: context.read<MapScreenViewModel>().places),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: context.read<MapScreenViewModel>().currentLocation,
                      builder: (ctx) => SvgPicture.asset(
                        'assets/location.svg',
                        width: 30,
                        height: 30,
                      ),
                    )
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _polylinePoints,
                      color: Colors.red,
                      strokeWidth: 3.0,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          await context.read<MapScreenViewModel>().getCurrentPosition(context)
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.location_searching,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
