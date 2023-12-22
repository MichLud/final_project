class Character {
  String? characterId;
  String name;
  String race;
  String characterClass;
  List<int> attributes = [];
  List<Spell> spells = [];

  Character({
    required this.name,
    required this.race,
    required this.characterClass,
    List<int>? attributes,
    this.characterId,

  }) {
    this.attributes = attributes ?? initializeAttributes();
    spells = initializeSpells();
  }

  initializeAttributes() {
    for (int i = 0; i < 6; i++) {
      attributes.add(10);
    }
  }
}

class Spell {
  int slotsUsed;
  int slotsMax;

  Spell({
    required this.slotsUsed,
    required this.slotsMax,
  });
}

List<Spell> initializeSpells() {
  List<Spell> spellList = [];
  for(int i=0; i<9; i++) {
    spellList.add(Spell(
        slotsUsed: 0,
        slotsMax: 0
    ));
  }
  return spellList;
}