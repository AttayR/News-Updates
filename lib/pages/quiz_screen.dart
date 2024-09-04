import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_updates/models/quiz_model.dart';
import 'package:news_updates/services/quiz.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestion> _currentQuestions = [];
  List<QuizQuestion> _allQuestions =
      socialAffairsQuestions; // Use your list of questions

  Map<int, String> _selectedAnswers = {}; // Track selected answers
  TextEditingController _nameController = TextEditingController();
  String _userName = '';
  Map<int, String> _correctAnswers =
      {}; // Store correct answers for displaying colors

  @override
  void initState() {
    super.initState();
  }

  void _generateNewQuestions() {
    final random = Random();
    final List<QuizQuestion> shuffledQuestions = List.from(_allQuestions)
      ..shuffle(random);
    setState(() {
      _currentQuestions = shuffledQuestions.take(10).toList();
      _correctAnswers = {
        for (int i = 0; i < _currentQuestions.length; i++)
          i: _currentQuestions[i].correctAnswer
      };
    });
  }

  void _submitAnswers() {
    int score = 0;

    // Calculate the score
    for (int i = 0; i < _currentQuestions.length; i++) {
      final question = _currentQuestions[i];
      if (_selectedAnswers[i] == question.correctAnswer) {
        score++;
      }
    }

    // Show the score in a dialog
    showDialog(
      context: context,
      builder: (context) {
        IconData icon;
        Color iconColor;
        String message;

        if (score < 5) {
          icon = Icons.cancel;
          iconColor = Colors.red;
          message =
              '$_userName! You scored $score/${_currentQuestions.length} points. Try Again!';
        } else {
          icon = Icons.emoji_events;
          iconColor = Colors.green;
          message =
              'Congratulations $_userName! You scored $score/${_currentQuestions.length} points!';
        }

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Icon(icon, color: iconColor, size: 50),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Quiz Submitted',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generateNewQuestions(); // Generate a new set of questions
              },
              child: Text('Take Another Quiz',
                  style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  void _startQuiz() {
    setState(() {
      _userName = _nameController.text.trim();
      if (_userName.isNotEmpty) {
        _generateNewQuestions();
      } else {
        // Show a message if the user name is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter your name to start the quiz.',)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "News",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: " Quiz",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 80, 2, 2),
        iconTheme: IconThemeData(
          color: Colors.white, // Color of the icons
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_currentQuestions.isEmpty) ...[
              Text(
                'Enter your name to start the quiz:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 80, 2, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  ),
                  child: Text('Start Quiz',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ] else ...[
              Text(
                'Answer the following questions:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _currentQuestions.length,
                  itemBuilder: (context, index) {
                    final question = _currentQuestions[index];
                    final selectedAnswer = _selectedAnswers[index];
                    final correctAnswer = _correctAnswers[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.question,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            ...question.options.map((option) {
                              return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: selectedAnswer,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswers[index] = value!;
                                  });
                                },
                                activeColor: option == correctAnswer
                                    ? Colors.green
                                    : (selectedAnswer == option &&
                                            selectedAnswer != correctAnswer
                                        ? Colors.red
                                        : null),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                contentPadding: EdgeInsets.all(5),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitAnswers,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 80, 2, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  ),
                  child: Text('Submit Quiz',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              
            ],
          ],
        ),
      ),
    );
  }
}
