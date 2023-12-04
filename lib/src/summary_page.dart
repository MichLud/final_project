import 'package:flutter/material.dart';
import 'widgets.dart';
import 'character.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key, required this.title});
  final String title;


  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  void _addCharacter() {
    // TODO: Implement addCharacter method

  }

  void _removeCharacter(/*Character character*/) {
    // TODO: Implement removeCharacter method

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, widget.title),
        drawer: buildDrawer(context),
        body: Center(
            child: Column(
                children: [
                  Container(
                    height: 150,
                    child: ListView.builder(
                        itemCount: characterList.length,
                        itemBuilder:(BuildContext context, int position) {
                          return ListTile(
                            title: Text(characterList[position].name),
                          );
                        }
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: Text('Add Character'),
                        onPressed: _addCharacter,
                      ),
                      ElevatedButton(
                        child: Text('Remove Character'),
                        onPressed: _removeCharacter,
                      ),
                    ],
                  ),
                  Text('Currently Selected'),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Name:'),
                      SizedBox(width: 10),
                      Text(characterList[0].name),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Race:'),
                      SizedBox(width: 10),
                      Text(characterList[0].race),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Class:'),
                      SizedBox(width: 10),
                      Text(characterList[0].characterClass),
                    ],
                  ),
                ])
        )
    );
  }
}
