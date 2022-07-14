import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  Doctor({required this.name, required this.id, required this.specialization, required this.lastMessageTime, required this.immadiatePatientId, required this.requestPatientId});
  final String name;
  final String id;
  final Timestamp lastMessageTime;
  final List<dynamic> immadiatePatientId;
  final List<dynamic> requestPatientId;
  final String specialization;

  static Doctor fromJson(Map<String, dynamic>? json) => Doctor(
        name: json!['name'],
        id: json['id'],
        lastMessageTime: json['lastMessageTime'],
        immadiatePatientId: json['immadiatePatientId'],
        requestPatientId: json['requestPatientId'],
        specialization: json['specialization'],
      );
  Map<String, dynamic> toJson()=>{
    'name': name,
    'id': id,
    'lastMessageTime': lastMessageTime,
    'immadiatePatientId': immadiatePatientId,
    'requestPatientId': requestPatientId,
    'specialization': specialization,
  };
}


class Patient {
  Patient({required this.gender, required this.name, required this.id, required this.email, required this.lastMessageTime, required this.immadiateDocId, required this.birthDate, required this.phone, required this.orderUuids, required this.address, required this.approved});
  final String name;
  final String id;
  final String email;
  final Timestamp lastMessageTime;
  final String immadiateDocId;
  final String birthDate;
  final String phone;
  final List<dynamic> orderUuids;
  final String address;
  final bool approved;
  final String gender;


  static Patient fromJson(Map<String, dynamic>? json) => Patient(
        name: json!['name'],
        id: json['id'],
        email: json['email'],
        lastMessageTime: json['lastMessageTime'],
        immadiateDocId: json['immadiateDocId'],
        phone: json['phone'],
        birthDate: json['birthDate'],
        orderUuids: json['orderUuids'],
        address: json['address'],
        approved: json['approved'],
        gender: json['gender'],

      );
  Map<String, dynamic> toJson()=>{
    'name': name,
    'id': id,
    'email': email,
    'lastMessageTime': lastMessageTime,
    'immadiateDocId': immadiateDocId,
    'phone': phone,
    'birthDate': birthDate,
    'orderUuids': orderUuids,
    'address': address,
    'approved': approved,
    'gender': gender,
  };
}
