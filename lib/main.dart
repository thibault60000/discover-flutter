import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Générateur de mots",
      home: RandomWords()
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      // Défini le Padding
      padding: const EdgeInsets.all(16.0),
      // Appelé pour chaque mot suggéré
      itemBuilder: (ctx, i) {
        // Toutes les lignes pairs, on créer un Divider
        if (i.isOdd) return Divider();
        // Divise i en 2 et retourne le résultat en Integer, permet de calculer le nombre de mots dans la ListView
        final index = i ~/ 2;
        // Si on arrive à la fin des mots disponibles, on en génère 10 de plus
        if (index >= _suggestions.length) {
          _suggestions.addAll(
              prefix0.generateWordPairs().take(10)); // peu compréhensible ..
        }
        // Appelé pour chaque mot suggéré, cela va créer un widget ListTitle permettant d'afficher le mot
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Générateur de mots'),
      ),
      body: _buildSuggestions()
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
