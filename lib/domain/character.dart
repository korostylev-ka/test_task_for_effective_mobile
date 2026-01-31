import 'package:test_task_effective_mobile/domain/status.dart';

import 'location.dart';

class Character {
  String image;
  String name;
  String species;
  Status status;
  String location;
  bool isFavourite;

  Character({
    required this.image,
    required this.name,
    required this.species,
    required this.status,
    required this.location,
    this.isFavourite = false
  });


  Character.favourite(Character character) : this(image: character.image, name: character.name, species: character.species, status: character.status, location: character.location, isFavourite: !character.isFavourite);
  @override
  String toString() {
    return 'Character{image: $image, name: $name, status: ${status.statusText}';
  }

}
