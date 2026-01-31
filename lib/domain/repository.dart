import 'package:test_task_effective_mobile/domain/character.dart';

abstract class Repository {
  Future<List<Character>> getAllCharacters();
  void addToFavourite(Character character);
  void removeFromFavourite(Character character);
}