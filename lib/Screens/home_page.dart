import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patient_register/Constants/colors.dart';
import 'package:patient_register/Constants/dimentions.dart';
import 'package:patient_register/Constants/text_style.dart';
import 'package:patient_register/Functions/firebase_api.dart';
import 'package:patient_register/Functions/firebase_auth.dart';
import 'package:patient_register/Screens/doctors_detail.dart';
import 'package:patient_register/Screens/doctors_list.dart';
import 'package:patient_register/Screens/health_info.dart';
import 'package:patient_register/Screens/login.dart';
import 'package:patient_register/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .0688,
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      inAsyncCall = true;
                    });
                    final _firebaseAuth = FirebaseAuth.instance;
                    final authService = AuthenticationService(_firebaseAuth);
                    await authService.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                    setState(() {
                      inAsyncCall = false;
                    });
                  },
                  child: const Text("Logout"),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/bejjing.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: size.height * .043),
            GestureDetector(
              onTap: () async {
                setState(() {
                  inAsyncCall = true;
                });
                Patient? me = await FirebaseApi.getMe();
                if (me != null) {
                  if (me.immadiateDocId.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const DoctorsList(
                                  haveDoc: "haveDoctor",
                                ))));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const DoctorsList())));
                  }
                }
                setState(() {
                  inAsyncCall = false;
                });
              },
              child: Container(
                color: kGreyCustome,
                height: size.height * .133,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: kIconSize,
                      color: Colors.red,
                    ),
                    SizedBox(width: size.width * .0188),
                    const Text(
                      "Find Doctors",
                      style: kContainerTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * .02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        inAsyncCall = true;
                      });
                      Patient? me = await FirebaseApi.getMe();
                      if (me != null) {
                        if (me.immadiateDocId.isNotEmpty) {
                          Doctor? doctor =
                              await FirebaseApi.getDoc(me.immadiateDocId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => DocDetail(
                                      docId: doctor.id,
                                      specialization: doctor.specialization,
                                      requestList: doctor.requestPatientId,
                                      docName: doctor.name,
                                    )),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const DoctorsList())));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content:Text("You don't have any doctor yet send a request to one"), duration: Duration(seconds: 4))
                                  );
                        }
                      }
                      setState(() {
                        inAsyncCall = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 5.0),
                      decoration: const BoxDecoration(
                        color: kGreyCustome,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: size.height * .133,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_sharp,
                            size: kIconSize,
                          ),
                          SizedBox(width: size.width * .0188),
                          const Text(
                            "My Doctors",
                            style: kContainerTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .0388,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const HealthInfo()));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: kLightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: size.height * .133,
                        child: const FittedBox(
                            child: Center(
                                child: Text(
                          "Health info",
                          style: kContainerTextStyle,
                        ))),
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  color: kEmergencyColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: const Center(
                  child: Text(
                    "Emergency Contact",
                    style: kContainerTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
