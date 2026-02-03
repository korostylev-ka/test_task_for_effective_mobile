import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_effective_mobile/state/app_state.dart';
import 'character_card.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final appState = AppState();

  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).getAllCharacters();
    Provider.of<AppState>(context, listen: false).getFavouriteCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AppState>(
        builder: (context, state, child) {
          return Container(
            child: ListView.builder(
              itemCount: state.characters.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CharacterCard(character: state.characters[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
