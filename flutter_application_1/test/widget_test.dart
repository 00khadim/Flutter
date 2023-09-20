import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mon Application Flutter'),
        ),
        body: MyTestWidget(), // Utilisez votre widget ici.
      ),
    ),
  );
}

class MyTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Mon widget de test',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              // Actions à effectuer lors de l'appui sur le bouton.
            },
            child: Text('Appuyez ici'),
          ),
        ],
      ),
    );
  }
}
