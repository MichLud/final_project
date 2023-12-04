import 'package:flutter/material.dart';
import 'summary_page.dart';
import 'attributes_page.dart';
import 'spells_page.dart';
import 'character.dart';

List<Character> characterList = getTestList();


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