import 'package:flutter/cupertino.dart';
import 'package:test_task_effective_mobile/data/repository_impl.dart';
import 'package:test_task_effective_mobile/domain/character.dart';
import 'package:test_task_effective_mobile/domain/loading_state.dart';

class AppState extends ChangeNotifier {
  final repository = RepositoryImpl();
  LoadingState loadingState = LoadingState();
  List<Character> _characters = [];
  List<Character> get characters => _characters;
  List<Character> _favouriteCharacters = [];
  List<Character> get favouriteCharacters => _favouriteCharacters;

  Future<List<Character>> getAllCharacters() async {
    loadingState.isLoading = true;
    await repository.loadCharacters();
    _characters = await repository.getAllCharacters();
    for (int i = 0; i < _characters.length; i++) {
      if (_favouriteCharacters.contains(_characters[i])) {
        _characters[i] = Character.favourite(_characters[i]);
      }
    }
    loadingState.isLoading = false;
    notifyListeners();
    return characters;
  }

  // Future<List<Character>> getAllCharacters() async {
  //   loadingState.isLoading = true;
  //   await Future.delayed(Duration(seconds: 4));
  //   _characters = await repository.loadCharacters();
  //   for (int i = 0; i < _characters.length; i++) {
  //     if (_favouriteCharacters.contains(_characters[i])) {
  //       _characters[i] = Character.favourite(_characters[i]);
  //     }
  //   }
  //   loadingState.isLoading = false;
  //   notifyListeners();
  //   return characters;
  // }

  Future<List<Character>> getFavouriteCharacters() async {
    _favouriteCharacters = await repository.getFavouriteCharacters();
    notifyListeners();
    return favouriteCharacters;
  }

  void sortFavouriteByName() {
    _favouriteCharacters.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void sortFavouriteByStatus() {
    _favouriteCharacters.sort((a, b) => a.status.statusText.compareTo(b.status.statusText));
    notifyListeners();
  }

  void sortFavouriteByLocation() {
    _favouriteCharacters.sort((a, b) => a.location.compareTo(b.location));
    notifyListeners();
  }

  void addToFavourite(Character character) async {
    await repository.addToFavourite(character);
    getFavouriteCharacters();
    for (int i = 0; i < _characters.length; i++ ) {
      if (character.name == _characters[i].name) {
        var newCharacter = Character.favourite(character);
        _characters[i] = newCharacter;
      }
    }
    notifyListeners();
  }
}