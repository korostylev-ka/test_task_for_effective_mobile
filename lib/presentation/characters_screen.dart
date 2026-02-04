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
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        Provider.of<AppState>(context, listen: false).getAllCharacters();

      }
    });
    Provider.of<AppState>(context, listen: false).getAllCharacters();
    Provider.of<AppState>(context, listen: false).getFavouriteCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Container(
      child: Consumer<AppState>(
        builder: (context, state, child) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.builder(
                  key: PageStorageKey<String>('controllerA'),
                  controller: scrollController,
                  itemCount: state.characters.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CharacterCard(character: state.characters[index]);
                  },
                ),
                Visibility(
                  visible: appState.loadingState.isLoading,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
