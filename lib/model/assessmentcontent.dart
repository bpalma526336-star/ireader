class AssessmentContent {
  final String readingpassagetitle;
  final String readingpassagecontent;
  final String questiontext;
  final List<String> options;
  final int correctoptionindex;

  AssessmentContent({
    required this.readingpassagetitle,
    required this.readingpassagecontent,
    required this.questiontext,
    required this.options,
    required this.correctoptionindex,
  });

  factory AssessmentContent.fromMap(Map<String, dynamic> map) {
    return AssessmentContent(
      readingpassagetitle: map['readingpassagetitle'] ?? "",
      readingpassagecontent: map['readingpassagecontent'] ?? "",
      questiontext: map['questiontext'] ?? "",
      options: List<String>.from(map['options'] ?? []),
      correctoptionindex: map['correctOptionindex'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'readingpassagetitle': readingpassagetitle,
      'readingpassagecontent': readingpassagecontent,
      'questiontext': questiontext,
      'options': options,
      'correctoptionindex': correctoptionindex,
    };
  }

  AssessmentContent copywith({
    String? readingpassagetitle,
    String? readingpassagecontent,
    String? questiontext,
    List<String>? options,
    int? correctoptionindex,
  }) {
    return AssessmentContent(
      readingpassagetitle: readingpassagetitle ?? this.readingpassagetitle,
      readingpassagecontent:
          readingpassagecontent ?? this.readingpassagecontent,
      questiontext: questiontext ?? this.questiontext,
      options: options ?? this.options,
      correctoptionindex: correctoptionindex ?? this.correctoptionindex,
    );
  }
}
