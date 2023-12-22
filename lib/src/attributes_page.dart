import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets.dart';
import 'character.dart';

class AttributesPage extends StatelessWidget {
  const AttributesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(
      builder: (context, characterProvider, _) {
        Character? selectedCharacter = characterProvider.selectedCharacter;

        return Scaffold(
          appBar: buildAppBar(context, title),
          drawer: buildDrawer(context),
          backgroundColor: Colors.brown[700],
          body: selectedCharacter != null
              ? _buildAttributesForCharacter(context, selectedCharacter)
              : _buildNoCharacterSelected(),
        );
      },
    );
  }

  Widget _buildAttributeTile(BuildContext context, String attribute, int value, Character selectedCharacter, int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ListTile(
          title: Text(attribute),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$value'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _showAdjustDialog(context, index, selectedCharacter);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getAttributeName(int index) {
    List<String> attributeNames = [
      'Strength:',
      'Dexterity:',
      'Constitution:',
      'Intelligence:',
      'Wisdom:',
      'Charisma:',
    ];
    return attributeNames[index];
  }
  Widget _buildAttributesForCharacter(BuildContext context, Character selectedCharacter) {
    return Center(
      child: Column(
        children: [
          Text(
            'Attribute summary for ${selectedCharacter.name}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7, // Set a fixed height
            child: ListView.builder(
              itemCount: selectedCharacter.attributes.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildAttributeTile(
                  context,
                  getAttributeName(index),
                  selectedCharacter.attributes[index],
                  selectedCharacter,
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNoCharacterSelected() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No character selected'),
      ),
    );
  }

}

void _showAdjustDialog(BuildContext context, int index, Character selectedCharacter) {
  int currentValue = selectedCharacter.attributes[index]; // Replace with your logic to get the current value

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Adjust Attribute'),
        content: SizedBox( // Wrap the content with SizedBox
          width: 200, // Adjust width as needed
          height: 100, // Adjust height as needed
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (currentValue > 0) {
                        setState(() {
                          currentValue--;
                        });
                      }
                    },
                  ),
                  Text('$currentValue'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (currentValue < 20) {
                        setState(() {
                          currentValue++;
                        });
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Update the value in your characterList or provider
              selectedCharacter.attributes[index] = currentValue; // Replace with your logic to update the value
              updateCharacterInFirebase(selectedCharacter);
              Provider.of<CharacterProvider>(context, listen: false).notifyListeners(); // Notify listeners
              Navigator.of(context).pop();
              // Call setState or update the provider to reflect changes in the UI
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

