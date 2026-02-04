import 'dart:convert';

import 'package:test_task_effective_mobile/data/db/character_entity.dart';
import 'package:test_task_effective_mobile/domain/character.dart';

import '../domain/status.dart';

class Mapper {
  final jsonImageKey = 'image';
  final jsonNameKey = 'name';
  final jsonSpeciesKey = 'species';
  final jsonLocationKey = 'location';
  final jsonStatusKey = 'status';
  final jsonIsFavouriteKey = 'is favourite';

  Character characterEntityToCharacter(CharacterEntity characterEntity) {
    return Character(
      image: characterEntity.image,
      name: characterEntity.name,
      species: characterEntity.species,
      status: Status.getStatusFromString(characterEntity.status),
      location: characterEntity.location,
      isFavourite: true,
    );
  }

  List<Character> characterEntityListToCharacterList(
    List<CharacterEntity> characterEntities,
  ) {
    List<Character> charactersList = [];
    for (var characterEntity in characterEntities) {
      charactersList.add(characterEntityToCharacter(characterEntity));
    }
    return charactersList;
  }

  Map<String, dynamic> mapCharacterToMap(Character character) {
    return {
      jsonImageKey: character.image,
      jsonNameKey: character.name,
      jsonSpeciesKey: character.species,
      jsonStatusKey: json.encode(character.status.toString()),
      jsonLocationKey: character.location,
      jsonIsFavouriteKey: character.isFavourite,
    };
  }

  Character mapCharacterFromJson(Map<String, dynamic> jsonCharacters) {
    return Character(
      image: jsonCharacters[jsonImageKey],
      name: jsonCharacters[jsonNameKey],
      species: jsonCharacters[jsonSpeciesKey],
      status: Status.getStatusFromString(
        json.decode(jsonCharacters[jsonStatusKey]),
      ),
      location: jsonCharacters[jsonLocationKey],
      isFavourite: jsonCharacters[jsonIsFavouriteKey],
    );
  }

  String encodeCharacters(List<Character> characters) {
    return json.encode(
      characters
          .map<Map<String, dynamic>>(
            (character) => mapCharacterToMap(character),
          )
          .toList(),
    );
  }

  List<Character> decodeCharacters(String? characters) {
    if (characters == null) return [];
    return (json.decode(characters) as List<dynamic>)
        .map<Character>((json) => mapCharacterFromJson(json))
        .toList();
  }
}
