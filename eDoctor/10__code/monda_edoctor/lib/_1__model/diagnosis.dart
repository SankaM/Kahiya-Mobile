class Diagnosis {
  final int id;

  final String? name;

  Diagnosis({
    required this.id,
    this.name,
  });

  factory Diagnosis.buildDetail(Map<String, dynamic> json) => Diagnosis(
    id: json['id'],
    name: json['name'],
  );
}
