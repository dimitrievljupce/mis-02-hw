import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_together/screens/dashboard_screen/darshboard_screen_viewmodel.dart';

import '../../widgets/place_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'Add a place',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          context
              .read<DashboardScreenViewModel>()
              .navigateToNewPlaceScreen(context);
        },
        icon: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 60, 10),
                child: Text(
                  'Find the best place to learn',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          context
                              .read<DashboardScreenViewModel>()
                              .findPlace(value);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Find your place...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.map_outlined),
                        onPressed: () {
                          context
                              .read<DashboardScreenViewModel>()
                              .navigateToMapScreen(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // results
              Expanded(
                child: ListView(
                  children: [
                    ...context
                        .watch<DashboardScreenViewModel>()
                        .filteredPlaces
                        .map(
                          (p) => PlaceCard(place: p),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
