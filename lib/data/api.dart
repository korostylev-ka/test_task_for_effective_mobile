import 'package:http/http.dart' as http;

class Api {
  final mainUrl = 'https://rickandmortyapi.com/api';

  Future<http.Response> getAllCharacters() async {
    final charactersResponse = await http.get(Uri.parse('${mainUrl}/character'));
    return charactersResponse;

  }

}