import 'dart:io';

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({
    required this.name,
    required this.image,
    required this.location,
  });
  final String name;
  final File image;
  final PlaceLocation location;
}
