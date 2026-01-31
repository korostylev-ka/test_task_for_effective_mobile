import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'character_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Consumer<AppState>(
          builder: (context, state, child) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton(
                    icon: Icon(Icons.sort),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(child: Text('Sort Option 1'))
                        ];
                      }
                  ),
                ),
                ListView.builder(
                  itemCount: state.favouriteCharacters.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CharacterCard(
                      character: state.favouriteCharacters[index],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
