import 'package:flutter/material.dart';

class AddAssessmentScreen extends StatefulWidget {
  const AddAssessmentScreen({super.key});

  @override
  State<AddAssessmentScreen> createState() => _AddAssessmentScreenState();
}

class QuestionFormItem {
  final TextEditingController questionController;
  final List<TextEditingController> optionsControllers;
  int correctOptionindex;

  QuestionFormItem({
    required this.questionController,
    required this.optionsControllers,
    required this.correctOptionindex,
  });

  void dispose() {
    questionController.dispose();
    optionsControllers.forEach((element) {
      element.dispose();
    });
  }
}

class _AddAssessmentScreenState extends State<AddAssessmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleassessmentcontroller = TextEditingController();
  final _titlereadingpassagecontroller = TextEditingController();
  final _readingpassagecontentcontroller = TextEditingController();
  final _timelimit = TextEditingController();
  final _date = TextEditingController();
  final _timeopen = TextEditingController();
  final _timeclose = TextEditingController();
  bool _isloading = false;
  List<QuestionFormItem> _questionItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
