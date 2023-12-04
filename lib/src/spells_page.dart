import 'package:flutter/material.dart';
import 'widgets.dart';
import 'character.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({super.key, required this.title});
  final String title;

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.title),
      drawer: buildDrawer(context),
      body: const Column(
        children: [
          Text("Level One"),
          Row(
            children: [
              Text("Total Slots: "),
              Text("TOTAL SLOTS"),
            ],
          ),
          Row(
            children: [
              Text("Slots Used: "),
              Text("TOTAL SLOTS USED"),
            ],
          ),
          Text("Level Two"),
          Row(
            children: [
              Text("Total Slots: "),
              Text("TOTAL SLOTS"),
            ],
          ),
          Row(
            children: [
              Text("Slots Used: "),
              Text("TOTAL SLOTS USED"),
            ],
          ),
          Text("Level Three"),
          Row(
            children: [
              Text("Total Slots: "),
              Text("TOTAL SLOTS"),
            ],
          ),
          Row(
            children: [
              Text("Slots Used: "),
              Text("TOTAL SLOTS USED"),
            ],
          ),
        ],
      ),
    );
  }
}
