import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  return runApp(Myapp());
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordState();
  }
}

class RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20);
  final _saveWords = <WordPair>[];

  Widget _buildRow(WordPair word) {
    final saved = _saveWords.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _biggerFont
      ),
      onTap: (){
        setState(() {
          if (saved) {
            _saveWords.remove(word);
          } else {
            _saveWords.add(word);
          }
        });
      },
      trailing: Icon(
        saved ? Icons.favorite : Icons.favorite_border,
        color: saved ? Colors.red : null,
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
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

  void _pushSaved() {
    // 通过命名路由跳转
    Navigator.of(context).pushNamed("saved", arguments: _saveWords);
    // 通过Navigator.push跳转
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SavedWordsWidget()));
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Words'),
        actions: [
          IconButton(icon: Icon(Icons.list) , onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

class SavedWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<WordPair> _savedWords = ModalRoute.of(context).settings.arguments;
    if (_savedWords == null) {
      _savedWords = <WordPair>[];
    }
    print(_savedWords);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Saved Words'),
        ),
        body: ListView.builder(itemBuilder: (context, i) {
          return ListTile(
            title: Text(_savedWords[i].asPascalCase),

          );
        },
        padding: EdgeInsets.all(10),
        itemCount: _savedWords.length),
      )
    );
  }
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter ds",
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      // 包括默认导航栏、标题和包含主屏幕的widget树的body属性
      home: RandomWords(),
      initialRoute: "/",
      routes: {'saved': (context) => SavedWordsWidget()},
    );
  }
}