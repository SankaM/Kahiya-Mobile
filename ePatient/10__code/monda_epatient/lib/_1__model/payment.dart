import 'package:monda_epatient/_1__model/appointment.dart';
import 'package:monda_epatient/_1__model/prescription.dart';

class Payment {
  final int id;

  final String orderNumber;

  final double amount;

  final bool paid;

  final DateTime generatedDate;

  final DateTime? requestDate;

  final DateTime? resultDate;

  final String paymentProvider;

  final Appointment? appointment;

  final Prescription? prescription;
  
  Payment({
    required this.id,
    required this.orderNumber,
    required this.amount,
    required this.paid,
    required this.generatedDate,
    required this.paymentProvider,
    this.requestDate,
    this.resultDate,
    this.appointment,
    this.prescription,
  });

  factory Payment.build(Map<String, dynamic> json) => Payment(
    id: json['id'],
    orderNumber: json['orderNumber'],
    amount: json['amount'],
    paid: json['paid'],
    generatedDate: DateTime.parse(json['generatedDate']),
    paymentProvider: json['paymentProvider'],
    appointment: json['appointment'] != null ? Appointment.build(json['appointment']) : null,
    prescription: json['prescription'] != null ? Prescription.buildDetail(json['prescription']) : null,
    requestDate: json['requestDate'] != null ? DateTime.parse(json['requestDate']) : null,
    resultDate: json['resultDate'] != null ? DateTime.parse(json['resultDate']) : null,
  );
}

class PaymentProvider {
  static const String PAYHERE = 'PAYHERE';
}
