class Character {
  String name;
  String race;
  String characterClass;
  List<int> attributes = [];

  Character({
    required this.name,
    required this.race,
    required this.characterClass,
  }) {
    initializeAttributes();
  }

  initializeAttributes() {
    for(int i=0; i<6; i++) {
      attributes.add(10);
    }
  }
}


newTestCharacter() {
  return Character(
      name: 'Eldric',
      race: 'Human',
      characterClass: 'Wizard'
  );
}

getTestList() {
  List<Character> characterList = [];
  for(int i = 0; i < 4; i++) {
    characterList.add(newTestCharacter());
  }
  return characterList;
}