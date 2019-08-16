import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main()=>runApp(JuniorApp());
class JuniorApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,//remode debug mode on barner
      theme: ThemeData(          // Add the 3 lines from here...

        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Wallet',
            style: TextStyle(
              color: Colors.white,

            ),
          ),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();//sauvegarde l'ensemble des mots selectionner sans doublons
  final _biggerFont = const TextStyle(fontSize: 12.0);
  @override

  void _pushSaved() {
    //Cette action modifie l'écran pour afficher le nouvel itinéraire
    Navigator.of(context).push(
      MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
                trailing: Icon( Icons.child_care,
                  color: Colors.green
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return Scaffold(         // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[      // Add 3 lines from here...
          IconButton(
              icon: Icon(Icons.list),
              onPressed: _pushSaved
          ),
        ],
      ),

      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(   // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // Add 9 lines from here...
        // setState()déclenche un appel à la méthode build () pour l'objet State, ce qui entraîne une mise à jour de l'interface utilisateur.
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

}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}