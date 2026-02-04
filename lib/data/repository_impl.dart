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
  final _infoKey = 'info';
  final _nameKey = 'name';
  final _imageKey = 'image';
  final _statusKey = 'status';
  final _speciesKey = 'species';
  final _locationKey = 'location';
  final _nextPageKey = 'next';
  final _prevPageKey = 'prev';
  final api = Api();
  final mapper = Mapper();
  final sharedPrefs = AppSharedPreferences();
  String _urlForGetCharacters = 'https://rickandmortyapi.com/api/character';
  List<Character> _charactersList = [];

  @override
  Future<void> addToFavourite(Character character) async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      if (!character.isFavourite) {
        await DBService.instance().insert(
          CharacterEntity.of(
            image: character.image,
            name: character.name,
            species: character.species,
            location: character.location,
            status: character.status.statusText,
          ),
        );
      } else {
        await DBService.instance().delete(character.name);
      }
    } else {
      AppSharedPreferences shared = AppSharedPreferences();
      await shared.addFavouriteCharacterToSharedPref(character);
    }
  }

  @override
  Future<List<Character>> loadCharacters() async {
    List<Character> characters = [];
    try {
      var response = await api.getCharacters(_urlForGetCharacters);

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
        String nextPage = data[_infoKey][_nextPageKey];
        _urlForGetCharacters = nextPage;
      }
    } catch (e) {
      return characters;
    }
    _charactersList.addAll(characters);
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

  @override
  Future<List<Character>> getAllCharacters() async {
    return _charactersList;
  }
}
