class DoctorStatistic {
  int? totalDiagnostics;

  int? totalPrescriptions;

  DoctorStatistic({this.totalDiagnostics, this.totalPrescriptions,});

  factory DoctorStatistic.build(Map<String, dynamic> json) => DoctorStatistic(
    totalDiagnostics: json['totalDiagnostics'],
    totalPrescriptions: json['totalPrescriptions'],
  );

  String get nonNullTotalDiagnostics {
    return totalDiagnostics == null ? '0' : totalDiagnostics!.toString();
  }

  String get nonNullTotalPrescriptions {
    return totalPrescriptions == null ? '0' : totalPrescriptions!.toString();
  }
}
