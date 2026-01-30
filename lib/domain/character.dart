import 'location.dart';

class Character {
  String image;
  String name;
  String species;
  String status;
  bool isFavourite;
  Location location;

  Character({
    required this.image,
    required this.name,
    required this.species,
    required this.status,
    required this.isFavourite,
    required this.location
  });
}
