import '../../domain/character.dart';
import '../../domain/status.dart';

class CharacterEntity {
  //int id;
  String image;
  String name;
  String species;
  //Status status;
  String location;

  static const dbFileName = 'character_database.db';
  static const table = 'characters';
  static const createDB = 'CREATE TABLE characters('
      'name TEXT PRIMARY KEY,'
      //'id INTEGER PRIMARY KEY,'
      'image TEXT,'
      'species TEXT,'
      'location TEXT'
      ')';

  CharacterEntity.of({required this.image, required this.name, required this.species,
    required this.location});

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'image': image,
      'species': species,
      'location': location,
    };
  }



}