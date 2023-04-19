import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;



  List<Question> _questionBank = [
    Question('Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS and Android, from a single codebase.', true),
    Question('Flutter was developed by Google.', true),
    Question('Flutter was initially released in 2017.', true),
    Question('Dart is the programming language used to write Flutter apps.', true),
    Question('Flutter uses a reactive programming model.', true),
    Question('Flutter provides a rich set of pre-built widgets for building complex user interfaces.', true),
    Question('Flutter apps can be compiled natively to run on iOS and Android devices.', true),
    Question('Flutter provides a hot reload feature for quickly iterating on app development.', true),
    Question('Flutter has a growing community of developers and contributors.', true),
    Question('Flutter is free and open-source software.', true),
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];


  void nextQuestion(bool answer) {
    if (answer == _questionBank[_questionNumber].questionAnswer) {
      _correctAnswers++;
    } else {
      _incorrectAnswers++;
    }
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }
  int getCorrectAnswers() {
    return _correctAnswers;
  }

  int getIncorrectAnswers() {
    return _incorrectAnswers;
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    return _questionNumber == _questionBank.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}
  //TODO: Step 2 Create a method called isFinished() here that checks to see if we have reached the last question. It should return (have an output) true if we've reached the last question and it should return false if we're not there yet.
  //TODO: Step 3 Part A - Create a method called isFinished() here that checks to see if we have reached the last question. It should return (have an output) true if we've reached the last question and it should return false if we're not there yet.

  //TODO: Step 3 Part B - Use a print statement to check that isFinished is returning true when you are indeed at the end of the quiz and when a restart should happen.

  //TODO: Step 4 Part B - Create a reset() method here that sets the questionNumber back to 0.

