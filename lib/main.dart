import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/summary_page.dart';
import 'firebase_options.dart';
import 'src/widgets.dart';
import 'src/character.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      ChangeNotifierProvider(
        create: (context) => CharacterProvider(),
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Fetch characters from Firebase Firestore
      future: getCharactersFromFirebase().first,
      builder: (BuildContext context, AsyncSnapshot<List<Character>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is being fetched, show a loading indicator
          return loadingScreen();
        } else {
          // If data retrieval is complete, initialize your app with retrieved characters
          if (snapshot.hasError) {
            return errorScreen(snapshot);
          } else {
            // If data retrieval is complete, store the retrieved characters into characterList
            if (snapshot.hasError) {
              return errorScreen(snapshot);
            } else {
              characterList = snapshot.data!;
              return characterPage();
            }
          }
        }
      }
    );
  }

  Widget characterPage() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CharacterProvider>(
          create: (_) => CharacterProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'D&D Character Sheet',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: SummaryPage(title: 'Character Summary Page'),
      ),
    );
  }

  Widget errorScreen(AsyncSnapshot<List<Character>> snapshot) {
    return MaterialApp(
            title: 'D&D Character Sheet',
            home: Scaffold(body: Center(child: Text('Error: ${snapshot.error}'))),
          );
  }

  Widget loadingScreen() {
    return MaterialApp(
          title: 'D&D Character Sheet',
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
  }
}

