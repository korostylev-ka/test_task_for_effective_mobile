import 'package:test_task_effective_mobile/domain/character.dart';

abstract class Repository {
  Future<List<Character>> getAllCharacters();
  Future<List<Character>> loadCharacters();
  Future<List<Character>> getFavouriteCharacters();
  void addToFavourite(Character character);
}