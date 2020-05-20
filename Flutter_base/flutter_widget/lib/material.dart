import 'package:flutter/material.dart';

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: () {
          print('taped actionbutton');
        },
      ),
      // persistentFooterButtons: <Widget>[
      //   IconButton(icon: Icon(Icons.import_contacts), onPressed: null),
      //   IconButton(icon: Icon(Icons.dashboard), onPressed: null)
      // ],
      bottomNavigationBar: Text('data'),
    );
  }
}
