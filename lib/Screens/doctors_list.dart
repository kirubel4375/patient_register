import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_register/Functions/firebase_api.dart';
import 'package:patient_register/Screens/doctors_detail.dart';
import 'package:patient_register/models/user_model.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key, this.haveDoc = ""}) : super(key: key);
  final String haveDoc;

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  bool buttonState = true;
  List<String> request = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Doctors"),
        ),
        body: widget.haveDoc.isNotEmpty
            ? Column(
              children: [
                const Spacer(),
                Card(
                  color: Colors.lightBlue.shade100,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 26.0),
                      child: Center(
                        child: Text(
                          "You already have a doctor talk to the admin to change your doctor",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
              ],
            )
            : FutureBuilder<List<Doctor>>(
                future: FirebaseApi.getDoctors(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(child: Text("Couldn't retrive data"));
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: ((context, index) {
                                List<Doctor>? doctors = snapshot.data;
                                final currentUser =
                                    FirebaseAuth.instance.currentUser!.uid;
                                request = doctors![index]
                                    .requestPatientId
                                    .cast<String>();
                                return ListTile(
                                  title: Text(doctors[index].name),
                                  subtitle: Text(
                                      "${DateTime.now().difference(doctors[index].lastMessageTime.toDate()).inHours} hours since last seen"),
                                  trailing: ElevatedButton(
                                    child: Text(request.isEmpty
                                        ? "Request"
                                        : request.contains(currentUser)
                                            ? "Request"
                                            : "Pending"),
                                    onPressed: request.isEmpty
                                        ? () async {
                                            await FirebaseApi
                                                .uploadRequest(
                                                    docId:
                                                        doctors[index].id,
                                                    requiredList: doctors[
                                                            index]
                                                        .requestPatientId);
                                          }
                                        : request.contains(currentUser)
                                            ? null
                                            : () async {
                                                String result = await FirebaseApi
                                                    .uploadRequest(
                                                        docId:
                                                            doctors[index]
                                                                .id,
                                                        requiredList:
                                                            doctors[index]
                                                                .requestPatientId);
                                                if (result ==
                                                    "upload success") {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "You have successfuly requested")));
                                                }
                                              },
                                  ),
                                );
                              }));
                        } else {
                          return const Center(
                              child: Text("No Doctors Availeble recently"));
                        }
                      } else {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                  }
                }),
      ),
    );
  }
}
