import 'package:ireader_web/model/assessmentcontent.dart';

class Assessment {
  final String id;
  final String assessmenttitle;
  final int timelimit;
  final String date;
  final String timeopen;
  final String timeclose;
  final List<AssessmentContent> questions;

  Assessment({
    required this.id,
    required this.assessmenttitle,
    required this.timelimit,
    required this.date,
    required this.timeopen,
    required this.timeclose,
    required this.questions,
  });

  factory Assessment.fromMap(String id, Map<String, dynamic> map) {
    return Assessment(
      id: id,
      assessmenttitle: map['assessmenttitle'],
      timelimit: map['timelimit'],
      date: map['date'],
      timeopen: map['timeopen'],
      timeclose: map['timeclose'],
      questions: ((map['questions'] ?? []) as List)
          .map((e) => AssessmentContent.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap({bool isUpdate = false}) {
    return {
      'assessmenttitle': assessmenttitle,
      'timelimit': timelimit,
      'date': date,
      'timeopen': timeopen,
      'timeclose': timeclose,
      'questions': questions.map((e) => e.toMap()).toList(),
    };
  }

  Assessment copywith({
    String? assessmenttitle,
    int? timelimit,
    String? date,
    String? timeopen,
    String? timeclose,
    List<AssessmentContent>? questions,
  }) {
    return Assessment(
      id: id,
      assessmenttitle: assessmenttitle ?? this.assessmenttitle,
      timelimit: timelimit ?? this.timelimit,
      date: date ?? this.date,
      timeopen: timeopen ?? this.timeopen,
      timeclose: timeclose ?? this.timeclose,
      questions: questions ?? this.questions,
    );
  }
}
