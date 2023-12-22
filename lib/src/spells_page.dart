import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets.dart';
import 'character.dart';

class SpellsPage extends StatelessWidget {
  final String title;

  const SpellsPage({Key? key, required this.title})  : super(key: key);

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
              ? _buildSpellsForCharacter(context, selectedCharacter)
              : _buildNoCharacterSelected(),
        );
      },
    );
  }

  Widget _buildSpellsForCharacter(BuildContext context, Character selectedCharacter) {
    return Center(
        child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView.builder(
                  itemCount: selectedCharacter.spells.length,
                  itemBuilder: (context, index) {
                    return _buildSpellTile(context, selectedCharacter, index);
                  },
                ),
              )
            ]
        )
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

  Widget _buildSpellTile(BuildContext context, Character selectedCharacter, int value) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Spell level ${value + 1}'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (selectedCharacter.spells[value].slotsUsed > 0) {
                      selectedCharacter.spells[value].slotsUsed--;
                      updateCharacterInFirebase(selectedCharacter); // Update Firebase
                      Provider.of<CharacterProvider>(context, listen: false).notifyListeners(); // Notify listeners
                    }
                  },
                ),
                Text('Slots Used: ${selectedCharacter.spells[value].slotsUsed}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (selectedCharacter.spells[value].slotsUsed < selectedCharacter.spells[value].slotsMax) {
                      selectedCharacter.spells[value].slotsUsed++;
                      updateCharacterInFirebase(selectedCharacter); // Update Firebase
                      Provider.of<CharacterProvider>(context, listen: false).notifyListeners(); // Notify listeners
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (selectedCharacter.spells[value].slotsMax > 0 && selectedCharacter.spells[value].slotsMax > selectedCharacter.spells[value].slotsUsed) {
                      selectedCharacter.spells[value].slotsMax--;
                      updateCharacterSpellsInFirebase(selectedCharacter); // Update Firebase
                      Provider.of<CharacterProvider>(context, listen: false).notifyListeners(); // Notify listeners
                    }
                  },
                ),
                Text('Max Slots: ${selectedCharacter.spells[value].slotsMax}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Implement logic to check against maximum slots if needed
                    selectedCharacter.spells[value].slotsMax++;
                    updateCharacterSpellsInFirebase(selectedCharacter); // Update Firebase
                    Provider.of<CharacterProvider>(context, listen: false).notifyListeners(); // Notify listeners
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




