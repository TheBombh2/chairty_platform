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
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
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
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image.path,
      'location': location.toJson(),
    };
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      image: File(json['image']),
      location: PlaceLocation.fromJson(json['location']),
    );
  }
}
