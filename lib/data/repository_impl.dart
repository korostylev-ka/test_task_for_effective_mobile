import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:test_task_effective_mobile/data/api.dart';
import 'package:test_task_effective_mobile/data/db/character_entity.dart';
import 'package:test_task_effective_mobile/data/shared_prefs/app_shared_preferences.dart';
import 'package:test_task_effective_mobile/domain/character.dart';
import 'package:test_task_effective_mobile/domain/repository.dart';
import '../domain/status.dart';
import 'db/db_service.dart';
import 'mapper.dart';

class RepositoryImpl implements Repository {
  final _resultsKey = 'results';
  final _nameKey = 'name';
  final _imageKey = 'image';
  final _statusKey = 'status';
  final _speciesKey = 'species';
  final _locationKey = 'location';
  final api = Api();
  final mapper = Mapper();
  final sharedPrefs = AppSharedPreferences();

  @override
  Future<void> addToFavourite(Character character) async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      await DBService.instance().insert(
        CharacterEntity.of(
          image: character.image,
          name: character.name,
          species: character.species,
          location: character.location,
        ),
      );
    } else {
      AppSharedPreferences shared = AppSharedPreferences();
      shared.addFavouriteCharacterToSharedPref(character);
    }
  }

  @override
  Future<List<Character>> getAllCharacters() async {
    List<Character> characters = [];
    try {
      var response = await api.getAllCharacters();
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        var list = data[_resultsKey];
        for (var characterItem in list) {
          String name = characterItem[_nameKey];
          String image = characterItem[_imageKey];
          String status = characterItem[_statusKey];
          String species = characterItem[_speciesKey];
          String location = characterItem[_locationKey][_nameKey];
          final character = Character(
            image: image,
            name: name,
            species: species,
            status: Status.getStatus(status),
            location: location,
          );
          characters.add(character);
        }
      }
    } catch (e) {
      return characters;
    }
    return characters;
  }

  @override
  Future<List<Character>> getFavouriteCharacters() async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final characterEntities = await DBService.instance()
          .getFavouriteCharacters();
      return mapper.characterEntityListToCharacterList(characterEntities);
    } else {
      return sharedPrefs.getFavouriteCharactersListFromSharedPref();
    }
  }
}
