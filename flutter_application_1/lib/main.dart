import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: QuizApp(),
    ),
  );
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  // Je commence par -1 parce que je demande le nom et il fait pas partie du quiz
  int indexQuestion = -1;
  int score = 0;
  bool quizTermine = false;
  String nomJoueur = ''; // Nom du joueur

  final List<Map<String, dynamic>> questions = [
    {
      'questionText': 'Qui est Zinedine Zidane ?',
      'answers': [
        '1. Un journaliste',
        '2. Un écrivain',
        '3. Un ancien footballeur',
      ],
      'correctAnswer': 3,
    },
    {
      'questionText': 'Où se trouve la Corse ?',
      'answers': [
        '1. Dans le Pacifique',
        '2. Dans l\'océan Indien',
        '3. En Méditerranée',
      ],
      'correctAnswer': 3,
    },
    {
      'questionText': 'Où se trouve la tour Eiffel ?',
      'answers': [
        '1. A Paris',
        '2. A Pékin',
        '3. A Los Angeles',
      ],
      'correctAnswer': 1,
    },
    {
      'questionText': 'Quelle est la capitale de la France ?',
      'answers': [
        '1. Tokyo',
        '2. Rome',
        '3. Paris',
      ],
      'correctAnswer': 3,
    },
    {
      'questionText': 'Qui a gagné la LDC en 2010 ?',
      'answers': [
        '1. Inter de Milan',
        '2. Barcalone',
        '3. Chelsea',
      ],
      'correctAnswer': 1,
    },
    {
      'questionText': 'Combien l\'être humain a-t-il de doigts en tout ? ',
      'answers': [
        '1. 10',
        '2. 20',
        '3. 5',
      ],
      'correctAnswer': 2,
    },
    {
      'questionText':
          'Quelle unité de misure principale utilisez-vous pour peser ?',
      'answers': [
        '1.	Kilogramme',
        '2.	Kilomètre ',
        '3. Centimètre ',
      ],
      'correctAnswer': 1,
    },
    {
      'questionText': 'Combien de jours y a-t-il dans une semaine ?',
      'answers': [
        '1.	7',
        '2.	4 ',
        '3. 5 ',
      ],
      'correctAnswer': 1,
    },
    {
      'questionText': 'Par quels animal le lait est-il fabriqué ?',
      'answers': [
        '1. Vache',
        '2.	Mouton ',
        '3. Poissons ',
      ],
      'correctAnswer': 1,
    },
    {
      'questionText': 'Combien y a-t-il de minutes dans une heure ?',
      'answers': [
        '1. 90',
        '2.	45 ',
        '3. 60 ',
      ],
      'correctAnswer': 3,
    },
  ];
// Je verifie que la repose est correct : est ce que il est egale à acoorectAnswer
  void verifierReponse(int reponseSelectionnee) {
    // si oui le score fait +1
    if (reponseSelectionnee == questions[indexQuestion]['correctAnswer']) {
      setState(() {
        score++;
      });
    } else {
// Réponse incorrecte, afficher la bonne réponse.
      // int bonneReponse = questions[indexQuestion]['correctAnswer'];
      // print('La bonne réponse est la réponse $bonneReponse.');
    }

    // Passer à la question suivante / afficher le score final
    setState(() {
      // je verifier est ce que j'ai posé toutes le question disponible
      if (indexQuestion < questions.length - 1) {
        indexQuestion++;
      } else {
        quizTermine = true;
      }
    });
  }

  void commencerJeu() {
    if (indexQuestion == -1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quel est votre nom ?'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  nomJoueur = value;
                });
              },
            ),
            actions: [
              TextButton(
                child: Text('Commencer le jeu'),
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la fenetre "dialogue"
                  setState(() {
                    indexQuestion =
                        0; // Commencez le jeu après avoir obtenu le nom
                  });
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        quizTermine = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Flutter'),
      ),
      body: Center(
        child: quizTermine
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$nomJoueur , votre score est de : $score', // afficher le score à jour et le nom
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Quiz terminé !', // afficher la fin
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: commencerJeu,
                    child: indexQuestion == -1
                        ? Text('Commencer le jeu')
                        : Text('Reccommencer'), //
                  ),
                  if (indexQuestion >=
                      0) // Affichez la question uniquement si indexQuestion est >= 0
                    Column(
                      children: <Widget>[
                        Text(
                          'Question ${indexQuestion + 1}/${questions.length}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          questions[indexQuestion]['questionText'] as String,
                          style: TextStyle(fontSize: 24),
                        ),
                        ...(questions[indexQuestion]['answers'] as List<String>)
                            .map((answer) {
                          return ElevatedButton(
                            onPressed: () => verifierReponse(
                                questions[indexQuestion]['answers']
                                        .indexOf(answer) +
                                    1),
                            child: Text(answer, style: TextStyle(fontSize: 20)),
                          );
                        }).toList(),
                        Text(
                          'Score: $score',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                ],
              ),
      ),
    );
  }
}
