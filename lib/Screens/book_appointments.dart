import 'package:flutter/material.dart';
import 'package:patient_register/Constants/colors.dart';

import '../Widgets/widgets.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  List<String> bodyParts = [
    "head",
    "toungae",
    "eye",
    "nose",
    "ear",
    "skin",
    "neck",
    "nape",
    "shoulder",
    "arm",
    "upper back",
    "lower back",
    "lung",
    "kidney",
    "stomach",
    "liver",
    "reproductive organs",
    "leg"
  ];
  String dropDownValue = "head";

  List<String> symptoms = [
    "headache",
    "stomachache",
    "throw up",
    "dihhariea",
    "throwing up and dihhariea",
    "caugh"
  ];
  String symptomsValue = "headache";
  List<String> howQue = [
    "once a day",
    "twice a day",
    "more than twice a day",
    "once a week",
    "twice a week",
    "more than twice a week"
  ];
  String howQueValue = "once a day";
  List<String> howLong =
      List<int>.generate(29, (int index) => (index + 1), growable: false)
          .map((e) => e == 1 ? "$e day" : "$e days")
          .toList();
  String howLongValue = "1 day";
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLoginRegisterColor,
        centerTitle: false,
        title: const Text("Book Appointments"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30.0),
          const Text(
            "Answer the following questinons",
            style: TextStyle(
              fontSize: 19.0,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Where do you feel the pain?",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 12.0),
          DropdownButtonFormField<String>(
            alignment: AlignmentDirectional.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            value: dropDownValue,
            items: bodyParts
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: const TextStyle(fontSize: 19.0)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                dropDownValue = value!;
              });
            },
          ),
          const SizedBox(height: 10.0),
          const Text(
            "What are the symptoms?",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 12.0),
          DropdownButtonFormField<String>(
            alignment: AlignmentDirectional.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            value: symptomsValue,
            items: symptoms
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: const TextStyle(fontSize: 19.0)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                symptomsValue = value!;
              });
            },
          ),
          const SizedBox(height: 10.0),
          const Text(
            "How quickly did your symptoms develop?",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 12.0),
          DropdownButtonFormField<String>(
            alignment: AlignmentDirectional.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            value: howQueValue,
            items: howQue
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: const TextStyle(fontSize: 19.0)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                howQueValue = value!;
              });
            },
          ),
          const SizedBox(height: 10.0),
          const Text(
            "How long have you had your symptoms?",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 12.0),
          DropdownButtonFormField<String>(
            alignment: AlignmentDirectional.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            value: howLongValue,
            items: howLong
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: const TextStyle(fontSize: 19.0)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                howLongValue = value!;
              });
            },
          ),
          const SizedBox(height: 12.0),
          selectedDate == null
              ? TextButton(
                  child: const Text("Pick a date"),
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025, 12, 31));
                        setState(() {});
                  },

                )
              : TextButton(
                  child: Text("${selectedDate!.day < 10 ? "0${selectedDate!.day}" : "${selectedDate!.day}"}/${selectedDate!.month < 10 ? "0${selectedDate!.month}": "${selectedDate!.month}"}/${selectedDate!.year}"),
                  onPressed: () async{
                    selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025, 12, 31));
                        setState(() {});
                  },
                ),
          const SizedBox(height: 12.0),
          const SizedBox(height: 12.0),
          ContainerRoundedButton(
            mainText: "book",
            onTap: (){
              
            },
          ),
        ],
      ),
    );
  }
}
