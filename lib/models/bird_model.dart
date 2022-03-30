import 'dart:io';

class BirdModel {
  final double longitude, latitude;
  final String? describeOfBird, nameOfBird;
  final File imageOfBird;

  BirdModel({
    required this.longitude,
    required this.latitude,
    required this.describeOfBird,
    required this.nameOfBird,
    required this.imageOfBird,
  });
}
