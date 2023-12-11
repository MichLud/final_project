import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets.dart';
import 'character.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {


  _addCharacter(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context) =>
            Text("New Dialog"),
    );
    /*
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
              onPressed: () {
                // Create a new character with entered information
                Character newCharacter = Character(
                  name: nameController.text,
                  race: raceController.text,
                  characterClass: classController.text,
                );

                // Add the new character to the characterList
                characterList.add(newCharacter);

                // Notify listeners or update the UI accordingly
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

     */
  }

  _removeCharacter(Character? character) {
    // Check if the characterList contains the character to remove
    if (characterList.contains(character)) {
      // Remove the specified character from the characterList
      characterList.remove(character);

      // Notify listeners or update the UI accordingly
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    CharacterProvider characterProvider = Provider.of<CharacterProvider>(context);
    Character? selectedCharacter = characterProvider.selectedCharacter;

    return Scaffold(
        appBar: buildAppBar(context, widget.title),
        drawer: buildDrawer(context),
        body: Center(
            child: Column(
                children: [
                  if (selectedCharacter != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addButton(),
                        ElevatedButton(
                          child: Text('Remove Character'),
                          onPressed: _removeCharacter(selectedCharacter),
                        ),
                      ],
                    ),
                    Text('Currently Selected'),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Name:'),
                        SizedBox(width: 10),
                        Text(selectedCharacter!.name,),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Race:'),
                        SizedBox(width: 10),
                        Text(selectedCharacter!.race,),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Class:'),
                        SizedBox(width: 10),
                        Text(selectedCharacter!.characterClass,),
                      ],
                    ),
                  ] else ...[
                    Text('No character selected'),
                    addButton(),
                  ]
                ])
        )
    );
  }

  Widget addButton() {
    return ElevatedButton(
      child: Text('Add Character'),
      onPressed: _addCharacter(context),
    );
  }
}
