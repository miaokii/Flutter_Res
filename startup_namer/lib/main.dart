import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter', 
      routes: {
        'saved words': (context){
          return SavedWords(likedWords: ModalRoute.of(context).settings.arguments);
        }
      },
      home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
// 私有变量
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20);
// 存储已经点赞的word
  final _liked = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // final aword = WordPair.random();
    // return Text(aword.asPascalCase);
    return Scaffold(
        appBar: AppBar(
          title: Text('startup name generator'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: (){
              Navigator.of(context).pushNamed('saved words', arguments: _liked);
            }
            )
          ],
        ),
        body: _buildSuggestions());
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final containPair = _liked.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          containPair ? Icons.favorite : Icons.favorite_border,
          color: containPair ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (containPair) {
              _liked.remove(pair);
            } else {
              _liked.add(pair);
            }
          });
        },
    );
  }
}

class SavedWords extends StatelessWidget {
  final Set<WordPair> likedWords;
  final List<WordPair> _listItem = List<WordPair>();
  // 构造函数
  SavedWords({
    Key key,
    @required this.likedWords
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    
    likedWords.forEach((element) {
      _listItem.add(element);
    });

    final Iterable<ListTile> tiles = likedWords.map( (WordPair pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: const TextStyle(fontSize: 18)
        ),
      );
    });

    final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved words'),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: divided,
      )
    );
  }
}