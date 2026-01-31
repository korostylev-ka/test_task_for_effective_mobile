import 'dart:convert';

import 'package:test_task_effective_mobile/data/api.dart';
import 'package:test_task_effective_mobile/domain/character.dart';
import 'package:test_task_effective_mobile/domain/repository.dart';

import '../domain/status.dart';

class RepositoryImpl implements Repository {
  final api = Api();

  @override
  void addToFavourite(Character character) {
    // TODO: implement addToFavourite
  }

  @override
  Future<List<Character>> getAllCharacters() async {
    List<Character> characters = [];
    try {
      var response = await api.getAllCharacters();
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        var list = data['results'];
        for (var characterItem in list) {
          String name = characterItem['name'];
          String image = characterItem['image'];
          String status = characterItem['status'];
          String species = characterItem['species'];
          String location = characterItem['location']['name'];
          final character = Character(
              image: image,
              name: name,
              species: species,
              status: Status.getStatus(status),
              location: location
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
  void removeFromFavourite(Character character) {
    // TODO: implement removeFromFavourite
  }
  
}