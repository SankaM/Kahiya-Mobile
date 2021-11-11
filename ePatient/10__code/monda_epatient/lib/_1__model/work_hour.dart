class WorkHour {
  String id;

  String? dayOfWeek;

  String? startTime;

  String? endTime;

  WorkHour({required this.id, this.dayOfWeek, this.startTime, this.endTime});

  factory WorkHour.build(Map<String, dynamic> json) => WorkHour(
    id: json['id'],
    dayOfWeek: json['dayOfWeek'],
    startTime: json['startTime'],
    endTime: json['endTime'],
  );

  String get nonNullDayOfWeek {
    return dayOfWeek == null ? '' : dayOfWeek!;
  }

  String get nonNullStartTime {
    return startTime == null ? '' : startTime!;
  }

  String get nonNullEndTime {
    return endTime == null ? '' : endTime!;
  }
}
