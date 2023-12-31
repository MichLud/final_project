import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

Stream<List<Character>> getCharactersFromFirebase() {
  CollectionReference characters = FirebaseFirestore.instance.collection('characters');

  return characters.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Character(
        name: doc['name'],
        race: doc['race'],
        characterClass: doc['characterClass'],
        characterId: doc.id,
        attributes: List<int>.from(doc['attributes']),
        // spells: List<Spell>.from(
          // (doc['spells'] as List<dynamic>).map((spell) => Spell(
            // slotsMax: spell['slotsMax'],
            // slotsUsed: spell['slotsUsed'],
          // )),
        );
    }).toList();
  });
}

Future<void> addCharacterToFirebase(Character newCharacter) async {
  CollectionReference characters =
  FirebaseFirestore.instance.collection('characters');

  DocumentReference docRef = await characters.add({
    'name': newCharacter.name,
    'race': newCharacter.race,
    'characterClass': newCharacter.characterClass,
    'attributes': newCharacter.attributes,
    // Add other properties as needed
  });

  newCharacter.characterId = docRef.id;
}

// Update information in Firebase Firestore
void updateCharacterInFirebase(Character character) {
  FirebaseFirestore.instance
      .collection('characters')
      .doc(character.characterId)
      .update({
    'name': character.name,
    'race': character.race,
    'characterClass': character.characterClass,
    'attributes': character.attributes,
  })
      .then((_) {
    print('Character updated successfully in Firestore!');
  })
      .catchError((error) {
    print('Error updating character: $error');
  });
}

Future<void> removeCharacterFromFirebase(String characterId) async {
  CollectionReference characters =
  FirebaseFirestore.instance.collection('characters');

  await characters.doc(characterId).delete();
}


class CharacterProvider extends ChangeNotifier {
  Character? _selectedCharacter;

  Character? get selectedCharacter => _selectedCharacter;

  void selectCharacter(Character character) {
    _selectedCharacter = character;
    notifyListeners();
  }

  void removeSelectedCharacter() {
    _selectedCharacter = null;
    notifyListeners();
  }

  void updateCharacterData({
    required String name,
    required String race,
    required String characterClass,
    required List<int> attributes,
    required List<Spell> spells,
  }) {
    if (_selectedCharacter != null) {
      _selectedCharacter!.name = name;
      _selectedCharacter!.race = race;
      _selectedCharacter!.characterClass = characterClass;
      _selectedCharacter!.attributes = attributes;
      _selectedCharacter!.spells = spells;
      notifyListeners();
    }
  }
}

Future<void> updateCharacterSpellsInFirebase(Character character) async {
  final List<Map<String, dynamic>> serializedSpells = character.spells.map((spell) {
    return {
      'slotsUsed': spell.slotsUsed,
      'slotsMax': spell.slotsMax,
    };
  }).toList();

  await FirebaseFirestore.instance
      .collection('characters')
      .doc(character.characterId)
      .update({
    'spells': serializedSpells,
  }).then((_) {
    print('Character spells updated successfully in Firestore!');
  }).catchError((error) {
    print('Error updating character spells: $error');
  });
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