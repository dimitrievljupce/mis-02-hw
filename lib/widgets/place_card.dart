import 'package:flutter/material.dart';

import '../core/domain/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        place.imageUri,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      Text(place.location),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: SizedBox(
              width: 50,
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(place.rating.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
