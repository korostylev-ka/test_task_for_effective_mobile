import 'package:test_task_effective_mobile/domain/character.dart';

abstract class Repository {
  List<Character> getAllCharacters();
  void addToFavourite(Character character);
  void removeFromFavourite(Character character);
}