class SchoolYear {
  final String id;
  final String schoolyear;

  SchoolYear({required this.id, required this.schoolyear});

  factory SchoolYear.fromMap(String id, Map<String, dynamic> map) {
    return SchoolYear(id: id, schoolyear: map['schoolyear'] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {'schoolyear': schoolyear};
  }

  SchoolYear copyWith({String? schoolyear}) {
    return SchoolYear(id: id, schoolyear: schoolyear ?? this.schoolyear);
  }
}
