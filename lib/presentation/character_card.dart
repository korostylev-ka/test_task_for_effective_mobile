import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_effective_mobile/data/repository_impl.dart';
import 'package:test_task_effective_mobile/domain/character.dart';
import 'package:test_task_effective_mobile/resources/dimens.dart';
import 'package:test_task_effective_mobile/resources/strings.dart';
import 'package:test_task_effective_mobile/state/app_state.dart';
import '../resources/decorations.dart';
import '../resources/text_styles.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({super.key, required this.character});

  final Character character;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  final repository = RepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Decorations.characterCardDecoration,
      margin: EdgeInsets.all(Dimens.marginCharacterCardContainer),
      padding: EdgeInsets.all(Dimens.paddingCharacterCardContainer),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.network(widget.character.image),
            ),
          ),
          SizedBox(width: Dimens.spaceBetweenBlocks),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Strings.name, style: TextStyles.characterCardField),
                      SizedBox(width: Dimens.spaceBetweenTextFields),
                      Expanded(child: Text(widget.character.name)),
                    ],
                  ),
                  SizedBox(height: Dimens.spaceBetweenTextFields),
                  Row(
                    children: [
                      Text(
                        Strings.status,
                        style: TextStyles.characterCardField,
                      ),
                      SizedBox(width: Dimens.spaceBetweenTextFields),
                      Text(widget.character.status.statusText),
                    ],
                  ),
                  SizedBox(height: Dimens.spaceBetweenTextFields),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.location,
                        style: TextStyles.characterCardField,
                      ),
                      SizedBox(width: Dimens.spaceBetweenTextFields),
                      Expanded(child: Text(widget.character.location)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              child: IconButton(
                onPressed: () {
                  Provider.of<AppState>(
                    context,
                    listen: false,
                  ).addToFavourite(widget.character);
                },
                icon: widget.character.isFavourite
                    ? Icon(Icons.star, color: Colors.red)
                    : Icon(Icons.star_border_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
