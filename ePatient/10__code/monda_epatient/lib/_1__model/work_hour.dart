class WorkHour {
  String id;

  String? dayOfWeek;

  String? time;

  WorkHour({required this.id, this.dayOfWeek, this.time,});

  factory WorkHour.build(Map<String, dynamic> json) => WorkHour(
    id: json['id'],
    dayOfWeek: json['dayOfWeek'],
    time: json['time'],
  );
}
