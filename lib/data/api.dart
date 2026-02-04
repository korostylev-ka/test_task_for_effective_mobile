import 'package:http/http.dart' as http;

class Api {
  final mainUrl = 'https://rickandmortyapi.com/api';

  Future<http.Response> getCharacters(String url) async {
    //final charactersResponse = await http.get(Uri.parse('${mainUrl}/${url}'));
    final charactersResponse = await http.get(Uri.parse(url));
    return charactersResponse;

  }

}