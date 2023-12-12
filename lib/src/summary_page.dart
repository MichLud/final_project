import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets.dart';
import 'character.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({
    Key? key, // Fix 'super.key' to 'Key? key'
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  _addCharacter(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController raceController = TextEditingController();
    TextEditingController classController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Character'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: raceController,
                  decoration: InputDecoration(labelText: 'Race'),
                ),
                TextField(
                  controller: classController,
                  decoration: InputDecoration(labelText: 'Class'),
                ),
              ],
            ),
          ),

          actions: [
            ElevatedButton(
              onPressed: () async {
                Character newCharacter = Character(
                  name: nameController.text,
                  race: raceController.text,
                  characterClass: classController.text,
                );

                // Add the new character to Firebase Firestore
                await addCharacterToFirebase(newCharacter);

                // Change the selected character the the newly created character
                Provider.of<CharacterProvider>(context, listen: false)
                    .selectCharacter(newCharacter);

                Navigator.pop(context); // Close the dialog
                setState(() {});
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  _removeCharacter(Character? character) async {
    if (character != null) {
      // Remove the character from Firebase Firestore
      await removeCharacterFromFirebase(character.characterId.toString());
      setState(() {});

      Provider.of<CharacterProvider>(context, listen: false)
          .removeSelectedCharacter();
    }
  }

  @override
  Widget build(BuildContext context) {
    CharacterProvider characterProvider =
    Provider.of<CharacterProvider>(context);
    Character? selectedCharacter = characterProvider.selectedCharacter;

    return Scaffold(
      appBar: buildAppBar(context, widget.title),
      drawer: buildDrawer(context),
      backgroundColor: Colors.brown[700],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (selectedCharacter != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  addButton(),
                  removeButton(selectedCharacter),
                ],
              ),
              const SizedBox(height: 20),

              characterSummary(selectedCharacter),
            ]
            else ...[
              addButton(),
              SizedBox(height:20),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Character Selected',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }


  Widget characterSummary(Character selectedCharacter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Currently Selected - ${selectedCharacter.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(selectedCharacter!.name),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Race:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(selectedCharacter!.race),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Class:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(selectedCharacter!.characterClass),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget addButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey, // Background color
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Button border radius
        ),
      ),
      child: Text('Add Character'),
      onPressed: () => _addCharacter(context),
    );
  }

  Widget removeButton(Character selectedCharacter) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey, // Background color
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Button border radius
        ),
      ),
      child: Text('Remove Character'),
      onPressed: () => _removeCharacter(selectedCharacter),
    );
  }
}