class Place {
  String name;
  double rating;
  String location;
  String imageUri;
  double? longitude;
  double? latitude;

  Place(
      {required this.name,
      required this.rating,
      required this.location,
      required this.imageUri,
      this.longitude,
      this.latitude});
}
