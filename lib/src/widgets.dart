import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'summary_page.dart';
import 'attributes_page.dart';
import 'spells_page.dart';
import 'character.dart';

List<Character> characterList = [];


Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Navigation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: Text('Select Character'),
          onTap: () {
            showCharacterSelectionDialog(
              context,
              characterList, // Your list of characters
                  (selectedCharacter) {
                Provider.of<CharacterProvider>(context, listen: false).selectCharacter(selectedCharacter);
                // Add any additional logic when a character is selected
              },
            );
          },
        ),
        ListTile(
          title: Text('Summary'),
          onTap: () {
            print('Navigating to Summary page');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SummaryPage(title: 'Summary Page',)),
            );
          },
        ),
        ListTile(
          title: Text('Attributes'),
          onTap: () {
            print('Navigating to Attributes page');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AttributesPage(title: 'Attributes Page',)),
            );
          },
        ),
        ListTile(
          title: Text('Spells'),
          onTap: () {
            print('Navigating to spells page');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SpellsPage(title: 'Spells Page',)),
            );
          }
        ),
        // Add more ListTiles for additional menu items
      ],
    ),
  );
}

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(title),
  );
}

class CharacterProvider extends ChangeNotifier {
  Character? _selectedCharacter;

  Character? get selectedCharacter => _selectedCharacter;

  void selectCharacter(Character character) {
    _selectedCharacter = character;
    notifyListeners();
  }

  void updateCharacterData({
    required String name,
    required String race,
    required String characterClass,
    required List<int> attributes,
  }) {
    if (_selectedCharacter != null) {
      _selectedCharacter!.name = name;
      _selectedCharacter!.race = race;
      _selectedCharacter!.characterClass = characterClass;
      _selectedCharacter!.attributes = attributes;
      notifyListeners();
    }
  }
}

void showCharacterSelectionDialog(BuildContext context, List<Character> characters, Function(Character) onSelectCharacter) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Select Character'),
        children: characters.map((character) {
          return SimpleDialogOption(
            onPressed: () {
              onSelectCharacter(character);
              Navigator.pop(context); // Close the dialog after selecting a character
            },
            child: Text(character.name),
          );
        }).toList(),
      );
    },
  );
}