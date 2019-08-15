import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

// My App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Générateur de mots",
        home: RandomWords(),
        theme: ThemeData(
         brightness: Brightness.dark,
         primaryColor: Colors.lightBlue[800],
         accentColor: Colors.cyan[600],
         textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
        ));
  }
}

// Random Words State
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = Set<WordPair>();

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (ctx, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(prefix0.generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  // Build Row
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // Route à pousser dans le Navigator
      MaterialPageRoute<void>(
        builder: (BuildContext ctx) {
          // Liste de Tiles
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return ListTile(title: Text(pair.asPascalCase, style: _biggerFont));
          });
          // Liste Divided
          final List<Widget> divided =
              ListTile.divideTiles(context: ctx, tiles: tiles).toList();
          // Scaffold
          return Scaffold(
              appBar: AppBar(title: Text('Noms Favoris')),
              body: ListView(children: divided));
        },
      ),
    );
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Générateur de mots'), actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ]),
        body: _buildSuggestions());
  }
}

// Random Words
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
