import 'package:flutter/material.dart';
import 'package:patient_register/Constants/colors.dart';
import 'package:patient_register/Screens/vital_page.dart';

class HealthInfo extends StatelessWidget {
  const HealthInfo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My health informations"),
      ),
      body: Column(
        children: [
          const Spacer(),
          GrayButtons(
            title: "Vitals",
            onTap: () async{
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>const VitalPage()));
            },
            notfications: 3,
          ),
          GrayButtons(
            title: "Lab Results",
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ShowLabResult(
              //               patientId: patientId,
              //               orderUuids: orderUuids,
              //             )));
            },
            notfications: 3,
          ),
          GrayButtons(
            title: "Pending Orders",
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ShowLabOrders(
              //               patientId: patientId,
              //               orderUuids: orderUuids,
              //             )));
            },
            notfications: 3,
          ),
          GrayButtons(
            title: "Prescription Records",
            onTap: () {},
            notfications: 3,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class GrayButtons extends StatelessWidget {
  const GrayButtons({
    required this.onTap,
    required this.title,
    required this.notfications,
    Key? key,
  }) : super(key: key);

  final Function()? onTap;
  final String title;
  final int notfications;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        width: double.infinity,
        height: 60.0,
        color: kButtonGrayColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .089,
            ),
            Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 19.0),
              ),
            ),
            Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Center(
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: Center(child: Text("$notfications")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
