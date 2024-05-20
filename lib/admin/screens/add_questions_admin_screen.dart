import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

// class AddQuestionsAdminScreen extends StatelessWidget {
//   const AddQuestionsAdminScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultScaffoldWidget();
//   }
// }

// class AddQuestionsAdminScreen extends StatefulWidget {
//   @override
//   _AddQuestionsAdminScreenState createState() => _AddQuestionsAdminScreenState();
// }
//
// class _AddQuestionsAdminScreenState extends State<AddQuestionsAdminScreen> {
//   List<Question> questions = [
//     Question(
//       text: 'What is the capital of France?',
//       options: ['Paris', 'London', 'Berlin', 'Madrid'],
//       correctOptionIndex: 0,
//     ),
//     Question(
//       text: 'What is 2 + 2?',
//       options: ['3', '4', '5', '6'],
//       correctOptionIndex: 1,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz App'),
//       ),
//       body: ReorderableColumn(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: List.generate(questions.length, (index) {
//           return buildQuestionCard(questions[index], index);
//         }),
//         onReorder: (int oldIndex, int newIndex) {
//           setState(() {
//             if (newIndex > oldIndex) {
//               newIndex -= 1;
//             }
//             final item = questions.removeAt(oldIndex);
//             questions.insert(newIndex, item);
//           });
//         },
//       ),
//     );
//   }
//
//   Widget buildQuestionCard(Question question, int index) {
//     return Card(
//       key: ValueKey(question),
//       margin: EdgeInsets.all(8.0),
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Question ${index + 1}: ${question.text}',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.0),
//             Column(
//               children: List.generate(question.options.length, (optionIndex) {
//                 return RadioListTile(
//                   title: Text(question.options[optionIndex]),
//                   value: optionIndex,
//                   groupValue: question.correctOptionIndex,
//                   onChanged: (value) {
//                     setState(() {
//                       question.correctOptionIndex = value as int;
//                     });
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Question {
//   String text;
//   List<String> options;
//   int correctOptionIndex;
//
//   Question({
//     required this.text,
//     required this.options,
//     required this.correctOptionIndex,
//   });
// }


////////////////////*


class AddQuestionsAdminScreen extends StatefulWidget {
  @override
  _AddQuestionsAdminScreenState createState() => _AddQuestionsAdminScreenState();
}

class _AddQuestionsAdminScreenState extends State<AddQuestionsAdminScreen> {
  List<Question1> questions = [];

  void _addQuestion() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddQuestionPage(
          onSave: (question) {
            setState(() {
              questions.add(question);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: questions.isEmpty
          ? Center(
        child: Text('No questions added. Tap the + button to add a question.'),
      )
          : ReorderableColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(questions.length, (index) {
          return buildQuestionCard(questions[index], index);
        }),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = questions.removeAt(oldIndex);
            questions.insert(newIndex, item);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQuestion,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildQuestionCard(Question1 question, int index) {
    return Card(
      key: ValueKey(question),
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${index + 1}: ${question.text}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Column(
              children: List.generate(question.options.length, (optionIndex) {
                return RadioListTile(
                  title: Text(question.options[optionIndex]),
                  value: optionIndex,
                  groupValue: question.correctOptionIndex,
                  onChanged: (value) {
                    setState(() {
                      question.correctOptionIndex = value as int;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class AddQuestionPage extends StatefulWidget {
  final Function(Question1) onSave;

  AddQuestionPage({required this.onSave});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(4, (_) => TextEditingController());
  int _correctOptionIndex = 0;

  void _saveQuestion() {
    if (_formKey.currentState?.validate() ?? false) {
      final question = Question1(
        text: _questionController.text,
        options: _optionControllers.map((controller) => controller.text).toList(),
        correctOptionIndex: _correctOptionIndex,
      );
      widget.onSave(question);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ...List.generate(4, (index) {
                return TextFormField(
                  controller: _optionControllers[index],
                  decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter option ${index + 1}';
                    }
                    return null;
                  },
                );
              }),
              SizedBox(height: 16.0),
              Text('Select the correct option:'),
              ...List.generate(4, (index) {
                return RadioListTile(
                  title: Text('Option ${index + 1}'),
                  value: index,
                  groupValue: _correctOptionIndex,
                  onChanged: (value) {
                    setState(() {
                      _correctOptionIndex = value as int;
                    });
                  },
                );
              }),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveQuestion,
                child: Text('Save Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

class Question1 {
  String text;
  List<String> options;
  int correctOptionIndex;

  Question1({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });
}

