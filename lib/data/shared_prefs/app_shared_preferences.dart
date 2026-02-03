import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_effective_mobile/domain/character.dart';
import 'package:test_task_effective_mobile/domain/status.dart';
import 'package:test_task_effective_mobile/data/mapper.dart';

class AppSharedPreferences {
  final _favourite = 'favourite characters';
  final mapper = Mapper();

  Future<void> addFavouriteCharacterToSharedPref(Character character) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Character> favourites = await getFavouriteCharactersListFromSharedPref();
    prefs.remove(_favourite);
    if (character.isFavourite) {
      favourites.remove(character);
    } else {
      favourites.add(Character.favourite(character));
    }
    prefs.remove(_favourite);
    saveFavouriteCharactersListToSharedPref(favourites);
  }

  Future<void> saveFavouriteCharactersListToSharedPref(List<Character> characters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_favourite, mapper.encodeCharacters(characters));
  }

  Future<List<Character>> getFavouriteCharactersListFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final charactersString = prefs.getString(_favourite);
    return mapper.decodeCharacters(charactersString);
  }


}
