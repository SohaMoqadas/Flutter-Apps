import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatefulWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class TrueFalseQuiz extends StatefulWidget {
  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('True/False Questions'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class MultipleChoiceQuiz extends StatefulWidget {
  @override
  _MultipleChoiceQuizState createState() => _MultipleChoiceQuizState();
}

class _MultipleChoiceQuizState extends State<MultipleChoiceQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('Multiple Choice Questions'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text(
              'Multiple Choice Questions',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizzlerState extends State<Quizzler> {
  bool _isQuizStarted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Quizzler'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Choose a Quiz'),
              ),
              ListTile(
                title: Text('True/False Questions'),
                onTap: () {setState(() {_isQuizStarted = true;});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrueFalseQuiz(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Multiple Choice Questions'),
                onTap: () {
                  setState(() {_isQuizStarted = true;});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleChoiceQuiz(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: _isQuizStarted
            ? SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        )
            :Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Center(
    child: ElevatedButton(
    onPressed: () {
    setState(() {
    _isQuizStarted = true;
    });
    },
    child: Text('Start Quiz'),
    ),
    ),
    ],
    ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();

}

class _QuizPageState extends State<QuizPage> {
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;


  List<Icon> scoreKeeper = [];

  int _timeRemaining = 10;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          checkAnswer(false);
        }
      });
    });
  }

  void resetTimer() {
    _timeRemaining = 10;
    _timer?.cancel();
  }

  void checkAnswer(bool userPickedAnswer) {
    resetTimer();
    bool correctAnswer = quizBrain.getCorrectAnswer();
    bool isFinished = quizBrain.isFinished();
    setState(() {
      if (isFinished) {
        Alert(
          context: context,
          title: 'Quiz finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBrain.reset();
        // Pass the scores to the next screen.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreScreen(
              correctAnswers: _correctAnswers,
              incorrectAnswers: _incorrectAnswers,
            ),
          ),
        );
        scoreKeeper = [];

        return;
      }

      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(
          Icon(Icons.check, color: Colors.green),
        );
        _correctAnswers++;
      } else {
        scoreKeeper.add(
          Icon(Icons.close, color: Colors.red),

        );
        _incorrectAnswers++;

      }

      quizBrain.nextQuestion(true);
      startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    resetTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '$_timeRemaining seconds remaining',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

class ScoreScreen extends StatelessWidget {
  final int correctAnswers;
  final int incorrectAnswers;

  ScoreScreen({
    required this.correctAnswers,
    required this.incorrectAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correct Answers: $correctAnswers',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Incorrect Answers: $incorrectAnswers',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}

