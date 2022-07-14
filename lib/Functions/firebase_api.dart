import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:patient_register/models/message.dart';
import 'package:patient_register/models/user_model.dart';

class FirebaseApi {
  final _auth = FirebaseAuth.instance;
  User? get getLoggedInUser => _auth.currentUser;

  static Future<List<Doctor>> getDoctors() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userQueryList =
        querySnapshot.docs;
    List<Doctor> userList =
        userQueryList.map((e) => Doctor.fromJson(e.data())).toList();
    return userList;
  }

  static Future<Patient>? getMe() async {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    final userId = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> me =
        await _firestore.collection("patients").doc(userId).get();
    Patient meComplete = Patient.fromJson(me.data());
    return meComplete;
  }

  static Future<Doctor> getDoc(String docId) async {
    final _firestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection("doctors").doc(docId).get();
    Doctor docComplete = Doctor.fromJson(doc.data());
    return docComplete;
  }

  static Future uploadMessage(
      {required String message, required String? recieverId}) async {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    final userId = _auth.currentUser!.uid;
    final refMessage =
        _firestore.collection('chats').doc(userId).collection('messages');
    refMessage.add(Messages(
            senderId: userId,
            recieverId: recieverId,
            message: message,
            createdAt: Timestamp.now())
        .toJson());
    final refUser = _firestore.collection('doctors');
    await refUser.doc(recieverId).update({
      'lastMessageTime': Timestamp.now(),
    });
  }

  static Future<String> uploadRequest(
      {required String docId, required List requiredList}) async {
    try {
      final _firebase = FirebaseFirestore.instance;
      final _auth = FirebaseAuth.instance;
      final currentUserId = _auth.currentUser!.uid;
      requiredList.add(currentUserId);
      await _firebase.collection("doctors").doc(docId).update({
        'requestPatientId': requiredList,
      });
      return "upload success";
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  static Future<String> checkApproved({required String email}) async {
    try {
      final _firebase = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> queryPatient = await _firebase
          .collection('patients')
          .where('email', isEqualTo: email)
          .get();
      List<Patient> patients =
          queryPatient.docs.map((e) => Patient.fromJson(e.data())).toList();
      Patient patient = patients.first;
      return patient.approved? "success": "fail";
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  // static Future updateRequest()async{
  //    try {
  //     final _firebase = FirebaseFirestore.instance;
  //     final _auth = FirebaseAuth.instance;
  //     final currentUserId = _auth.currentUser!.uid;
  //     await _firebase.collection("request").doc(docId).set({
  //       "from": currentUserId,
  //       "to": docId,
  //     });
  //     return "upload success";
  //   } on FirebaseException catch (_) {
  //     return "upload failed";
  //   }

  // }

  static Future<Map<List<String>, List<String>>> getVitalinfo()async{
    String? email = FirebaseAuth.instance.currentUser!.email;
  DatabaseReference  ref = FirebaseDatabase.instance.ref("${email!.split('.').first+ email.split('.').last}/Heartbeat");
  DatabaseEvent event = await ref.once();
  DatabaseReference ref1 = FirebaseDatabase.instance.ref("${email.split('.').first + email.split('.').last}/Blood Oxygen");
  DatabaseEvent event1 = await ref1.once();
  final event1Value = event1.snapshot.children;
   final values = event.snapshot.children;
   List<String> heartbeatValue = [];
   List<String> oxygenLevelValue = [];
   for(DataSnapshot dataSnapshot in values){
    heartbeatValue.add(dataSnapshot.value.toString());
   }
   for(DataSnapshot dataSnapshot in event1Value){
    oxygenLevelValue.add(dataSnapshot.value.toString());
   }
   Map<List<String>, List<String>> mapTwoStrings = {};
   mapTwoStrings[heartbeatValue] = oxygenLevelValue;
   return mapTwoStrings;
   }
}
