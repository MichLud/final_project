import 'package:flutter/material.dart';
import 'widgets.dart';
import 'character.dart';

class AttributesPage extends StatefulWidget {
  const AttributesPage({super.key, required this.title});
  final String title;

  @override
  State<AttributesPage> createState() => _AttributesPageState();
}

class _AttributesPageState extends State<AttributesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.title),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          Row(
            children: [
              Text('Strength: '),
              Text(characterList[0].attributes[0].toString()),
            ],
          ),
          Row(
            children: [
              Text('Dexterity: '),
              Text(characterList[0].attributes[1].toString()),
            ],
          ),
          Row(
            children: [
              Text('Constitution: '),
              Text(characterList[0].attributes[2].toString()),
            ],
          ),
          Row(
            children: [
              Text('Intelligence: '),
              Text(characterList[0].attributes[3].toString()),
            ],
          ),
          Row(
            children: [
              Text('Wisdom: '),
              Text(characterList[0].attributes[4].toString()),
            ],
          ),
          Row(
            children: [
              Text('Charisma: '),
              Text(characterList[0].attributes[5].toString()),
            ],
          ),
        ],
      ),
    );
  }
}
