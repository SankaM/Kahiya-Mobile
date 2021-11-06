class DoctorStatistic {
  int? totalDiagnostics;

  int? totalPrescriptions;

  DoctorStatistic({this.totalDiagnostics, this.totalPrescriptions,});

  factory DoctorStatistic.build(Map<String, dynamic> json) => DoctorStatistic(
    totalDiagnostics: json['totalDiagnostics'],
    totalPrescriptions: json['totalPrescriptions'],
  );
}
